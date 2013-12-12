require 'formula'

class Cgoban < Formula
  homepage 'http://www.igoweb.org/~wms/comp/cgoban/index.html'
  url 'http://www.igoweb.org/~wms/comp/cgoban/cgoban-1.9.12.tar.gz'
  sha1 'b892a9f60c7b176ce3a156f1b391541e3803f794'

  depends_on :x11

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"

    bin.mkpath
    man6.mkpath

    system "make", "install", "PREFIX=#{prefix}", "MANDIR=#{man}"
  end

  test do
    system "#{bin}/cgoban", "--version"
  end
end
