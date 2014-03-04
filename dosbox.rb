require 'formula'

class Dosbox < Formula
  homepage 'http://www.dosbox.com/'
  url 'https://downloads.sourceforge.net/project/dosbox/dosbox/0.74/dosbox-0.74.tar.gz'
  sha1 '2d99f0013350efb29b769ff19ddc8e4d86f4e77e'

  depends_on :libpng
  depends_on 'sdl'
  depends_on 'sdl_net'
  depends_on 'sdl_sound'

  def install
    ENV.fast

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--disable-sdltest",
                          "--enable-core-inline"
    system "make"

    bin.install 'src/dosbox'
    man1.install gzip('docs/dosbox.1')
  end
end
