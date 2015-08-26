require 'formula'

class Mednafen < Formula
  homepage 'http://mednafen.sourceforge.net/'
  url 'https://downloads.sourceforge.net/project/mednafen/Mednafen/0.9.38.5/mednafen-0.9.38.5.tar.bz2'
  sha1 'b6dff2ff97673e4183c5628d49b6ac05c341b325'

  bottle do
    sha1 "84e3203ab953fbed5a22499a2ad64aa6f17f4d80" => :yosemite
    sha1 "b251d8fb372df3d5665156a6bd49fd17a5eed618" => :mavericks
    sha1 "09ade315444535e750cb204d0280c9c7d833f12a" => :mountain_lion
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
