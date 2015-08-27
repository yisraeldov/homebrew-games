require 'formula'

class Mednafen < Formula
  homepage 'http://mednafen.sourceforge.net/'
  url 'https://downloads.sourceforge.net/project/mednafen/Mednafen/0.9.38.5/mednafen-0.9.38.5.tar.bz2'
  sha256 '10c5e6ba0d822cf2e5aaa236ca86e6ec489a56043530ba3fdc20f70929e738e8'

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    sha1 "84e3203ab953fbed5a22499a2ad64aa6f17f4d80" => :yosemite
    sha1 "b251d8fb372df3d5665156a6bd49fd17a5eed618" => :mavericks
    sha1 "09ade315444535e750cb204d0280c9c7d833f12a" => :mountain_lion
  end

  depends_on 'pkg-config' => :build
  depends_on 'sdl'
  depends_on 'libcdio'
  depends_on 'libsndfile'
  depends_on 'coreutils'

  def install
    # Force compilation with built in 
    ENV['CC'] = '/usr/bin/gcc'
    ENV['LD'] = '/usr/bin/gcc'
    ENV['CXX'] = '/usr/bin/g++'
    ENV['ac_ct_CXX'] = 'g++'
    ENV.delete('CFLAGS')
    ENV.delete('CXXFLAGS')
    ENV.delete('MAKEFLAGS')
    ENV.delete('CPPFLAGS')
    ENV.delete('PKG_CONFIG_LIBDIR') 
    ENV.delete('PKG_CONFIG_PATH')
	
    system( "./configure --prefix=#{prefix} --disable-dependency-tracking --build=x86_64-apple-darwin`uname -r` " )
    system "make"
    system "make install"
  end
end
