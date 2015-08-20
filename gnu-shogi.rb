class GnuShogi < Formula
  desc "GNU Shogi (Japanese Chess)"
  homepage "https://www.gnu.org/software/gnushogi/"
  url "http://ftpmirror.gnu.org/gnushogi/gnushogi-1.4.2.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gnushogi/gnushogi-1.4.2.tar.gz"
  sha256 "1ecc48a866303c63652552b325d685e7ef5e9893244080291a61d96505d52b29"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install", "MANDIR=#{man6}", "INFODIR=#{info}"
  end

  test do
    (testpath/"test").write <<-EOS.undent
      7g7f
      exit
    EOS
    system "#{bin}/gnushogi < test"
  end
end
