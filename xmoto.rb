require 'formula'

class Xmoto < Formula
  url 'http://download.tuxfamily.org/xmoto/xmoto/0.5.10/xmoto-0.5.10-src.tar.gz'
  homepage 'http://xmoto.tuxfamily.org/'
  sha1 '692d50a9c91791cd06ee84846632651b44544fcc'

  depends_on 'libxml2'
  depends_on 'gettext'
  depends_on 'jpeg'
  depends_on 'sdl'
  depends_on 'sdl_mixer'
  depends_on 'sdl_net'
  depends_on 'sdl_ttf'
  depends_on 'lua'
  depends_on 'ode'
  depends_on "libpng"

  # Fixes compiling against libpng on Lion. See:
  # http://todo.xmoto.tuxfamily.org/index.php?do=details&task_id=783
  patch :DATA

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-sdltest",
                          "--with-internal-xdg=1",
                          "--with-apple-opengl-framework"
    system "make install"
  end
end

__END__
diff --git a/src/image/tim_png.cpp b/src/image/tim_png.cpp
index 75fd545..a1d1cf6 100644
--- a/src/image/tim_png.cpp
+++ b/src/image/tim_png.cpp
@@ -24,6 +24,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <stdio.h>
 #include <string.h>
+#include <zlib.h>
 #include "tim.h"
 #include "png.h"
