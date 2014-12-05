require 'formula'

class Nazghul < Formula
  url 'https://downloads.sourceforge.net/project/nazghul/nazghul/nazghul-0.7.0/nazghul-0.7.0.tar.gz'
  homepage 'http://myweb.cableone.net/gmcnutt/nazghul.html'
  sha1 '1d67c3fb3b03b3f8b5170305f3d97428932e6c4f'

  depends_on 'sdl'
  depends_on 'sdl_image'
  depends_on 'sdl_mixer'
  depends_on "libpng"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-sdltest"
    # Not sure why the ifdef is commented out in this file
    inreplace "src/skill.c", "#include <malloc.h>", ""
    system "make install"
  end

  def caveats; <<-EOS.undent
    The built-in game for this engine is called Haxima. To run:
        haxima.sh
    EOS
  end
end
