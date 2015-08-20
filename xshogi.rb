class Xshogi < Formula
  desc "X11 interface for GNU Shogi"
  homepage "https://www.gnu.org/software/gnushogi/"
  url "http://ftpmirror.gnu.org/gnushogi/xshogi-1.4.2.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gnushogi/xshogi-1.4.2.tar.gz"

  depends_on :x11
  depends_on "gnu-shogi"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking"
    system "make", "install"
  end
end
