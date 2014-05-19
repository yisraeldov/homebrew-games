require 'formula'

class Mednafen < Formula
  homepage 'http://mednafen.sourceforge.net/'
  url 'https://prdownloads.sourceforge.net/mednafen/mednafen-0.9.34.1.tar.bz2'
  sha1 'ee3d2b2afb3a4377b4d48513ba9c9048f5530690'

  depends_on 'pkg-config' => :build
  depends_on 'sdl'
  depends_on 'libcdio'
  depends_on 'libsndfile'

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
