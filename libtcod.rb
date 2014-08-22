require 'formula'

class Libtcod < Formula
  homepage 'http://doryen.eptalys.net/libtcod/'
  url 'https://bitbucket.org/jice/libtcod/get/1.5.1.tar.bz2'
  sha1 '4bf117f2d29b0ad851552c84e8745dcf3ae0af2a'

  depends_on 'cmake' => :build
  depends_on 'sdl'

  # Remove unnecessary X11 check - our SDL doesn't use X11
  patch :DATA

  def install
    system "cmake", ".", *std_cmake_args
    system "make"

    # cmake produces an install target, but it installs nothing
    lib.install 'src/libtcod.dylib'
    lib.install 'src/libtcod-gui.dylib'
    include.install Dir['include/*']
    # don't yet know what this is for
    libexec.install 'data'
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index a573528..e88419b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -57,7 +57,6 @@ if(MSVC OR MINGW)
 	LINK_DIRECTORIES(${DEPENDENCY_DIR}/SDL-1.2.15/lib/${LIB_DIR}/ 
 					${DEPENDENCY_DIR}/zlib-1.2.3/lib/${ZLIB_DIR}/)
 ELSE()
-	find_package(X11 REQUIRED)
 	find_package(SDL REQUIRED)
 	find_package(ZLIB REQUIRED)
 	find_package(Threads REQUIRED)
@@ -72,7 +71,6 @@ ELSE()
 			      ${SDL_INCLUDE_DIR} # again, singular...
 			      ${ZLIB_INCLUDE_DIRS}
 			      ${M_LIB_INCLUDE_DIRS}
-			      ${X11_INCLUDE_DIRS}
 			      ${OPENGL_INCLUDE_DIRS})
 	IF(CMAKE_BUILD_TYPE MATCHES "Debug")
 		find_library(EFENCE_LIBRARY efence PATHS /usr/lib /usr/local/lib)
