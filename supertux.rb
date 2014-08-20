require 'formula'

class Supertux < Formula
  homepage 'http://supertux.lethargik.org/'
  url 'https://downloads.sf.net/project/supertux.berlios/supertux-0.1.3.tar.bz2'
  sha1 'ad783011fbf15a8a56ca8680769a8c2a15abc515'

  depends_on 'sdl'
  depends_on 'sdl_image'
  depends_on 'sdl_mixer'
  depends_on 'physfs'
  depends_on 'libogg'
  depends_on 'libvorbis'

  devel do
    url 'https://supertux.googlecode.com/files/supertux-0.3.4.tar.bz2'
    sha1 '9502cdad9ab8d04074ed57a6568fc87c7e857dcb'

    depends_on 'cmake' => :build
    depends_on 'glew'
    depends_on 'boost'

    fails_with :clang do
      cause <<-EOS.undent
        error: implicit instantiation of undefined template 'std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >'
        std::string message;
        EOS
    end
  end

  stable do
    # Patch from macports port
    # https://trac.macports.org/ticket/29635
    patch :p0, :DATA
  end

  def install
    if build.devel?
      args = std_cmake_args
      args << '-DINSTALL_SUBDIR_BIN=bin' << '-DINSTALL_SUBDIR_SHARE=share/supertux2'
      system "cmake", ".", *args
      system "make"
      bin.install ['supertux2']
      share.mkpath
      (share + 'supertux2').mkpath
      (share + 'supertux2').install Dir['data/*']
    else
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{prefix}"
      system "make install"
    end
  end

  test do
    system "supertux"
  end
end

__END__
--- src/menu.h.orig	2005-06-21 16:16:07.000000000 -0500
+++ src/menu.h	2011-08-29 03:28:39.000000000 -0500
@@ -207,7 +207,7 @@
 
   bool isToggled(int id);
 
-  void Menu::get_controlfield_key_into_input(MenuItem *item);
+  void get_controlfield_key_into_input(MenuItem *item);
 
   void draw   ();
   void draw_item(int index, int menu_width, int menu_height);

