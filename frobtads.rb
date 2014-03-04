require 'formula'

class Frobtads < Formula
  homepage 'http://www.tads.org/frobtads.htm'
  url 'http://www.tads.org/frobtads/frobtads-1.2.3.tar.gz'
  sha1 '330217c0b6ee298bf9db986bc4ce84b86aa5e3e2'

  head do
    url 'git://git.assembla.com/frobtads.git'

    depends_on :autoconf
    depends_on :automake
    depends_on :libtool
  end

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
