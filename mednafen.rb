require 'formula'

class Mednafen < Formula
  homepage 'http://mednafen.sourceforge.net/'
  url 'https://downloads.sourceforge.net/project/mednafen/Mednafen/0.9.36.5/mednafen-0.9.36.5.tar.bz2'
  sha1 '02d441e18083daa539f0193121ac760882be9d19'

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    sha1 "45286a92cbc85e38829fdcb5703eaeb1a1dc0b59" => :yosemite
    sha1 "bdbd0bbd01103c0fac28cf3d4ff56c75d58827a7" => :mavericks
    sha1 "5a5bb6b80586188c459def85dd6b436b05cacf60" => :mountain_lion
  end

  depends_on 'pkg-config' => :build
  depends_on 'sdl'
  depends_on 'libcdio'
  depends_on 'libsndfile'

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
