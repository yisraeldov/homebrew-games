require 'formula'

class Dosbox < Formula
  homepage 'http://www.dosbox.com/'
  url 'https://downloads.sourceforge.net/project/dosbox/dosbox/0.74/dosbox-0.74.tar.gz'
  sha1 '2d99f0013350efb29b769ff19ddc8e4d86f4e77e'

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    cellar :any
    sha1 "c705acee92739e73802870940c377a1d25f2d3ca" => :yosemite
    sha1 "f19db38fe5ed10d2ce74c84835548d3725313e8e" => :mavericks
    sha1 "a5d26fbb678ab9b68d35a23f9296fd39a8587d74" => :mountain_lion
  end

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
