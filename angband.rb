class Angband < Formula
  homepage "http://rephial.org/"
  url "http://rephial.org/downloads/4.0/angband-4.0.1.tar.gz"
  sha256 "f65814a521960e05a0b1cb0badbefb7b229530fd74616ed3a23fb898faa528d0"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    sha256 "0ddb3329005ec7acda583248b4ce59cad057fd4cb642942000035695c1c76daa" => :yosemite
    sha256 "2abb9acb242fcf925ec62cc818d7577261d6f7b9df2d505173da6bb4b47148d7" => :mavericks
    sha256 "930a2861f6faac4d8756f64d2340cbafda08129ee9d28e507962cca5afbf7697" => :mountain_lion
  end

  head do
    url "https://github.com/angband/angband.git"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
  end

  option "with-x11", "Build with X11"
  depends_on "homebrew/dupes/tcl-tk" => "with-x11" if build.with? "x11"

  def install
    ENV["NCURSES_CONFIG"] = "#{MacOS.sdk_path}/usr/bin/ncurses5.4-config"
    system "./autogen.sh" if build.head?

    args = %W[
      --prefix=#{prefix}
      --bindir=#{bin}
      --libdir=#{libexec}
      --enable-curses
      --with-ncurses-prefix=#{MacOS.sdk_path}/usr
      --disable-sdl
      --disable-sdl-mixer
    ]
    args << "--disable-x11" if build.without? "x11"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"angband", "--help"
  end
end
