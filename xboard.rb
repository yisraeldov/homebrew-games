class Xboard < Formula
  homepage "https://www.gnu.org/software/xboard/"
  url "http://ftpmirror.gnu.org/xboard/xboard-4.8.0.tar.gz"
  mirror "https://ftp.gnu.org/gnu/xboard/xboard-4.8.0.tar.gz"
  sha256 "c88f48fc7fe067be0a13b8d121c38551145f889719c212717884e5e82d902d17"

  bottle do
    sha256 "b01bdebeec0ca39e2d34acf08a210e4c22843f7b541a1a04d5a777dff95341de" => :yosemite
    sha256 "ababbd0b0d60bf6571cfe8b7e18e620dc654b8a82d22bd877b850c00a93851c4" => :mavericks
    sha256 "68355a1ab17eeaf7d1efb0c3bcdeaefe5ac754f2b33908bb9771fb88b3f2d80b" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "fairymax" => :recommended
  depends_on "gettext"
  depends_on "cairo"
  depends_on "librsvg"
  depends_on "gtk+"

  # Fix build bugs in XBoard GTK 4.8.0:
  # 1) suppress needless #include <cairo/cairo-xlib.h>
  #    (Homebrew's cairo no longer includes xlib, and Xboard w/GTK doesn't need it)
  #    filed w/patch: https://savannah.gnu.org/bugs/?45773
  # 2) suppress an obsolete reference to XFontSet
  #    filed w/patch: https://savannah.gnu.org/bugs/?45774
  # Hopefully these patches will be included in XBoard 4.8.1.
  patch :DATA

  def install
    args = ["--prefix=#{prefix}",
            "--with-gtk",
            "--without-Xaw",
            "--disable-zippy"]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"xboard", "--help"
  end
end

__END__
diff --git a/draw.c b/draw.c
index d0b3eda..066b3d4 100644
--- a/draw.c
+++ b/draw.c
@@ -54,7 +54,6 @@
 #include <stdio.h>
 #include <math.h>
 #include <cairo/cairo.h>
-#include <cairo/cairo-xlib.h>
 #include <librsvg/rsvg.h>
 #include <librsvg/rsvg-cairo.h>

diff --git a/gtk/xboard.c b/gtk/xboard.c
index a8afcb3..9a27d2b 100644
--- a/gtk/xboard.c
+++ b/gtk/xboard.c
@@ -62,7 +62,6 @@
 #include <pwd.h>
 #include <math.h>
 #include <cairo/cairo.h>
-#include <cairo/cairo-xlib.h>
 #include <gtk/gtk.h>

 #if !OMIT_SOCKETS
@@ -212,11 +211,13 @@ RETSIGTYPE CmailSigHandler P((int sig));
 RETSIGTYPE IntSigHandler P((int sig));
 RETSIGTYPE TermSizeSigHandler P((int sig));
 char *InsertPxlSize P((char *pattern, int targetPxlSize));
+#ifdef TODO_GTK
 #if ENABLE_NLS
 XFontSet CreateFontSet P((char *base_fnt_lst));
 #else
 char *FindFont P((char *pattern, int targetPxlSize));
 #endif
+#endif
 void DelayedDrag P((void));
 void ICSInputBoxPopUp P((void));
 void MoveTypeInProc P((GdkEventKey *eventkey));
diff --git a/gtk/xoptions.c b/gtk/xoptions.c
index 67675ff..4f5df57 100644
--- a/gtk/xoptions.c
+++ b/gtk/xoptions.c
@@ -48,7 +48,6 @@ extern char *getenv();
 #include <stdint.h>

 #include <cairo/cairo.h>
-#include <cairo/cairo-xlib.h>
 #include <gtk/gtk.h>
 #include <gdk/gdkkeysyms.h>
 #ifdef OSXAPP
