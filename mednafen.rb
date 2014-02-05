require 'formula'

class Mednafen < Formula
  homepage 'http://mednafen.sourceforge.net/'
  url 'http://forum.fobby.net/index.php?t=getfile&id=572'
  sha1 'aa57533321b79ae63f5a64e2bbbdb31a397902d3'
  version '0.9.32.1-WIP'

  option 'with-snes', 'Build with SNES support'

  depends_on 'pkg-config' => :build
  depends_on 'sdl'
  depends_on 'libcdio'
  depends_on 'libsndfile'

  def install
    args = %W[--prefix=#{prefix} --disable-dependency-tracking]
    args << "--disable-snes" if ENV.compiler == :clang
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end

  def caveats; <<-EOS.undent
    The SNES module will not be compiled if you use clang as the compiler.
    EOS
  end
end
