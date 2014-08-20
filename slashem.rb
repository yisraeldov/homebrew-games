require 'formula'

class Slashem < Formula
  homepage 'http://slashem.sourceforge.net'
  url 'https://downloads.sourceforge.net/project/slashem/slashem-source/0.0.8E0F1/se008e0f1.tar.gz'
  sha1 'eec6615f8ed04691a996ef62a7305f6812e6ae26'
  version "0.0.8E0F1"

  skip_clean 'slashemdir/save'

  depends_on 'pkg-config' => :build

  # Fixes compilation error in OS X:
  # http://sourceforge.net/tracker/index.php?func=detail&aid=1644971&group_id=9746&atid=109746
  patch :DATA

  def install
    ENV.j1
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-mandir=#{man}",
                          "--with-group=admin",
                          "--with-owner=#{`echo $USER`}"
    system "make install"

    man6.install 'doc/slashem.6'
    man6.install 'doc/recover.6'
  end
end

__END__
diff --git a/win/tty/termcap.c b/win/tty/termcap.c
index c3bdf26..8d00b11 100644
--- a/win/tty/termcap.c
+++ b/win/tty/termcap.c
@@ -960,7 +960,7 @@ cl_eos()			/* free after Robert Viduya */
 
 #include <curses.h>
 
-#if !defined(LINUX) && !defined(__FreeBSD__)
+#if !defined(LINUX) && !defined(__FreeBSD__) && !defined(__APPLE__)
 extern char *tparm();
 #endif
