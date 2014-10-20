require 'formula'

class Mednafen < Formula
  homepage 'http://mednafen.sourceforge.net/'
  url 'https://downloads.sourceforge.net/project/mednafen/Mednafen/0.9.36.4/mednafen-0.9.36.4.tar.bz2'
  sha1 '4c8bd353159785918f03a1d0f5c48c229a903402'

  depends_on 'pkg-config' => :build
  depends_on 'sdl'
  depends_on 'libcdio'
  depends_on 'libsndfile'

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
