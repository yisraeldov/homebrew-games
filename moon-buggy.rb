require 'formula'

class MoonBuggy < Formula
  homepage 'http://www.seehuhn.de/pages/moon-buggy'
  url 'http://m.seehuhn.de/programs/moon-buggy-1.0.tar.gz'
  sha1 '82dc1d504b4f81aa54d3d57837a03d17b5624a86'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}"
    system "make install"
  end

  test do
    system "moon-buggy"
  end
end
