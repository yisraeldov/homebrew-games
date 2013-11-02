require 'formula'

class Dopewars < Formula
  homepage 'http://dopewars.sourceforge.net'
  url 'http://prdownloads.sourceforge.net/dopewars/dopewars-1.5.12.tar.gz'
  sha1 'ad46a38e225680e591b078eeec563d47b96684bc'

  depends_on 'pkg-config' => :build
  depends_on 'glib'

  def install
    inreplace "src/Makefile.in", "$(dopewars_DEPENDENCIES)", ""
    inreplace "ltmain.sh", "need_relink=yes", "need_relink=no"
    inreplace "src/plugins/Makefile.in", "LIBADD =", "LIBADD = -module -avoid-version"
    system "./configure", "--disable-gui-client",
                          "--disable-gui-server",
                          "--enable-plugins",
                          "--enable-networking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system "#{bin}/dopewars", "-v"
  end
end
