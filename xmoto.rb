class Xmoto < Formula
  desc "2D motocross platform game"
  homepage "http://xmoto.tuxfamily.org/"
  url "http://download.tuxfamily.org/xmoto/xmoto/0.5.11/xmoto-0.5.11-src.tar.gz"
  sha256 "a584a6f9292b184686b72c78f16de4b82d5c5b72ad89e41912ff50d03eca26b2"

  head do
    url "svn://svn.tuxfamily.org/svnroot/xmoto/xmoto/trunk"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
  end

  depends_on "sdl"
  depends_on "sdl_mixer"
  depends_on "sdl_net"
  depends_on "sdl_ttf"
  depends_on "ode"
  depends_on "libpng"
  depends_on "jpeg"
  depends_on "libxml2"
  depends_on "gettext" => :recommended
  depends_on "libxdg-basedir"
  depends_on "lua" => :recommended

  def install
    # Fix issues reported upstream
    # http://todo.xmoto.tuxfamily.org/index.php?do=details&task_id=812

    # Set up single precision ODE
    ENV.append_to_cflags "-DdSINGLE"

    # Use same type as Apple OpenGL.framework
    inreplace "src/glext.h", "unsigned int GLhandleARB", "void *GLhandleARB"

    # Handle quirks of C++ hash_map
    inreplace "src/include/xm_hashmap.h" do |s|
      if build.head?
        s.gsub! "tr1/", ""
        s.gsub! "::tr1", ""
      else
        s.gsub! "s2) {", "s2) const {"
      end
    end

    system "./bootstrap" if build.head?
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-xmltest",
                          "--disable-sdltest",
                          "--with-apple-opengl-framework",
                          "--with-asian-ttf-file="
    system "make", "install"
  end

  test do
    system "#{bin}/xmoto", "-h"
  end
end
