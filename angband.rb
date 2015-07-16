class Angband < Formula
  homepage "http://rephial.org/"
  url "http://rephial.org/downloads/4.0/angband-4.0.1.tar.gz"
  sha256 "f65814a521960e05a0b1cb0badbefb7b229530fd74616ed3a23fb898faa528d0"

  bottle do
    sha256 "ece28191291c732d1a9c77f52154d0a7a1ac9b6a64cacafd56ed226e8411178a" => :yosemite
    sha256 "4dfdf04dcdad019c47c12239a60e3d75ef72968c37dd8de5ccd8f4d59d0f26db" => :mavericks
    sha256 "4169c9197bc346c86e170406afb893ebf1efbed914152edb0890bfbd108ddb84" => :mountain_lion
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
