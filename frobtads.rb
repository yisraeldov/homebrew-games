require 'formula'

class Frobtads < Formula
  homepage 'http://www.tads.org/frobtads.htm'
  url 'http://www.tads.org/frobtads/frobtads-1.2.3.tar.gz'
  sha1 '330217c0b6ee298bf9db986bc4ce84b86aa5e3e2'

  head do
    url 'https://github.com/realnc/frobtads.git'

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
