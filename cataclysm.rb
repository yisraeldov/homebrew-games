class Cataclysm < Formula
  homepage 'http://www.cataclysmdda.com/'
  url 'https://github.com/CleverRaven/Cataclysm-DDA/archive/0.B.tar.gz'
  sha1 '28849b6293037deefe320313eb88d076ef4d339d'
  version '0.B'

  head "https://github.com/CleverRaven/Cataclysm-DDA.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    cellar :any
    sha1 "b1b39dc6f76b718ddf4cc25355202bfd233d882c" => :yosemite
    sha1 "6184eb62cc81e0e40145c1334494571bcfe4d8b3" => :mavericks
    sha1 "411e24d73210b15c47859727aad6c090413a0a8f" => :mountain_lion
  end

  needs :cxx11

  depends_on "gettext"
  # needs `set_escdelay`, which isn't present in system ncurses before 10.6
  depends_on "homebrew/dupes/ncurses" if MacOS.version < :snow_leopard

  option "with-tiles", "Enable tileset support"

  if build.with? "tiles"
    depends_on "sdl2"
    depends_on "sdl2_image"
    depends_on "sdl2_ttf"
  end

  def install
    ENV.cxx11

    # cataclysm tries to #import <curses.h>, but Homebrew ncurses installs no
    # top-level headers
    ENV.append_to_cflags "-I#{Formula['ncurses'].include}/ncursesw" if MacOS.version < :snow_leopard

    args = %W[
      NATIVE=osx RELEASE=1
      CXX=#{ENV.cxx} LD=#{ENV.cxx} CXXFLAGS=#{[ENV.cxxflags, ENV.cppflags].join(" ")}
    ]

    args << "TILES=1" if build.with? "tiles"
    args << "CLANG=1" if ENV.compiler == :clang

    system "make", *args

    # no make install, so we have to do it ourselves
    if build.with? "tiles"
      libexec.install "cataclysm-tiles", "data", "gfx"
    else
      libexec.install "cataclysm", "data"
    end

    inreplace "cataclysm-launcher" do |s|
      s.change_make_var! 'DIR', libexec
    end
    bin.install "cataclysm-launcher" => "cataclysm"
  end
end
