class Angband < Formula
  homepage "http://rephial.org/"
  url "http://rephial.org/downloads/3.5/angband-v3.5.1.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/a/angband/angband_3.5.1.orig.tar.gz"
  sha256 "c5ca3ab75fd820a49eb2b9ab8b1c2a811ff992276f9800cc61c686e90bd4d447"

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
