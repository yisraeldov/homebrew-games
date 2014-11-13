require 'formula'

class Wesnoth < Formula
  homepage 'http://www.wesnoth.org/'
  head 'https://github.com/wesnoth/wesnoth.git'

  stable do
    url 'https://downloads.sourceforge.net/project/wesnoth/wesnoth-1.10/wesnoth-1.10.7/wesnoth-1.10.7.tar.bz2'
    sha1 '86e329585244c377a1863f64dd534bc7bbcc7acf'

    patch do
      # This adds pkg_config_libdir to scons/pkgconfig py file
      url 'https://github.com/wesnoth/wesnoth/commit/9f93831a2397d45560a9f1e36a40aac38d4affc3.diff'
      sha1 '8fb0de0af39075b249493e948dabe5868ecb681c'
    end

    patch do
      # This adds OS_ENV option to SConstruct
      url 'https://github.com/wesnoth/wesnoth/commit/9683de3d841c29a921155c41f7905032bf3a8f18.diff'
      sha1 '5f4b1d05d9a76495f102efc8e7522c825e94b5a0'
    end
  end

  devel do
    url 'https://downloads.sourceforge.net/project/wesnoth/wesnoth/wesnoth-1.11.19/wesnoth-1.11.19.tar.bz2'
    sha1 '1f98b1043525d4721e39f51add9af0abf08d2904'

    patch do
      # This patch fixes bug #22921
      url 'https://github.com/wesnoth/wesnoth/commit/b6f916adf1a5489985433c0016e0661a02452f1a.diff'
      sha1 '0fedaba6997a07339bb6ea3986c003697ef3c844'
    end
  end

  option "with-ccache", "Speeds recompilation, convenient for beta testers"
  option "with-debug", "Build with debugging symbols"

  depends_on 'scons' => :build
  depends_on 'gettext' # will become a build-only dep as of 1.12
  depends_on 'fribidi'
  depends_on 'boost'
  depends_on 'libpng'
  depends_on 'fontconfig'

  depends_on 'cairo'
  depends_on 'pango'

  if OS.linux?
    # On linux, x11 driver is needed or the clipboard code doesn't work, images don't load
    depends_on 'sdl' => 'with-x11'
  else
    depends_on 'sdl'
  end

  depends_on 'sdl_image'
  depends_on 'sdl_mixer' => 'with-libvorbis' # The music is in .ogg format
  depends_on 'sdl_net'
  depends_on 'sdl_ttf'

  depends_on 'ccache' => :optional

  def install
    args = %W[prefix=#{prefix} docdir=#{doc} mandir=#{man} fifodir=#{var}/run/wesnothd]
    # use system-installed gettext on linux;
    # the gettext formula doesn't provide libintl.h on Linux.
    # note: when 1.12 is released, this exception can be removed.
    args << "gettextdir=#{Formula["gettext"].opt_prefix}" unless OS.linux?
    args << "OS_ENV=true"
    args << "install"
    args << "wesnoth"
    args << "wesnothd"
    args << "-j#{ENV.make_jobs}"
    args << "ccache=true" if build.with? "ccache"
    args << "build=debug" if build.with? "debug"

    scons *args
  end

end
