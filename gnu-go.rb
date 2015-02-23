class GnuGo < Formula
  homepage 'https://www.gnu.org/software/gnugo/gnugo.html'
  url 'http://ftpmirror.gnu.org/gnugo/gnugo-3.8.tar.gz'
  mirror 'https://ftp.gnu.org/gnu/gnugo/gnugo-3.8.tar.gz'
  sha1 'a8ce3c7512634f789bc0c964fe23a5a6209f25db'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-readline=/usr/lib"
    system "make install"
  end
end
