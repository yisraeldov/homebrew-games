require "formula"

class Freeciv < Formula
  homepage "http://freeciv.wikia.com"
  url "https://downloads.sourceforge.net/project/freeciv/Freeciv%202.4/2.4.3/freeciv-2.4.3.tar.bz2"
  sha1 "ed7473e28c53e4bfbfc2535c15c7ef17d4e34204"
  head "svn://svn.gna.org/svn/freeciv/trunk"

  option "disable-nls" , "Disable NLS support"
  option "without-sdl" , "Disable the SDL Freeciv client"
  option "with-gtk+" , "Disable the GTK+ Freeciv client"
  option "with-gtk+3" , "Enable the GTK+3 Freeciv client"

  depends_on "pkg-config" => :build
  depends_on "readline"
  depends_on :x11
  depends_on "gettext" unless build.include? "disable-nls"

  depends_on "sdl" => :recommended
  depends_on "sdl_image" if build.with? "sdl"
  depends_on "sdl_mixer" if build.with? "sdl"

  depends_on "gtk+" => :optional
  depends_on "gtk+3" => :optional
  depends_on "glib" if build.with?("gtk+") || build.with?("gtk+3")

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-readline=#{Formula["readline"].opt_prefix}
    ]

    if build.include? "disable-nls"
      args << "--disable-nls"
    else
      gettext = Formula["gettext"]
      args << "CFLAGS=-I#{gettext.include}"
      args << "LDFLAGS=-L#{gettext.lib}"
    end

    build_client = []
    build_client << "sdl" if build.with? "sdl"
    build_client << "gtk" if build.with? "gtk+"
    build_client << "gtk+3" if build.with? "gtk+3"
    args << "--enable-client=" + build_client.join(",") unless build_client.empty?
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/freeciv-server", "-v"
  end
end
