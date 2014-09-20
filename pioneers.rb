require "formula"

class Pioneers < Formula
  homepage "http://pio.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/pio/Source/pioneers-15.1.tar.gz"
  sha1 "cea94cd77edef31b3f9e601077dff9b199dfeaf4"

  fails_with :clang do
    build 318
    cause "'#line directive requires a positive integer' argument in generated file"
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "gtk+"
  depends_on "gdk-pixbuf"
  depends_on "librsvg" # svg images for gdk-pixbuf
  depends_on "hicolor-icon-theme"

  def install
    # fix usage of echo options not supported by sh
    inreplace "Makefile.in", /\becho/, "/bin/echo"

    # GNU ld-only options
    inreplace Dir["configure{,.ac}"] do |s|
      s.gsub!(/ -Wl\,--as-needed/, "")
      s.gsub!(/ -Wl,-z,(relro|now)/, "")
    end

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
