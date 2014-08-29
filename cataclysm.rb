require 'formula'

class Cataclysm < Formula
  homepage 'http://www.cataclysmdda.com/'
  url 'https://github.com/CleverRaven/Cataclysm-DDA/archive/0.A.tar.gz'
  sha1 '019493366fe7f7a27f4ef77f11d6f3c3133ed7ea'
  version '0.A'

  head "https://github.com/CleverRaven/Cataclysm-DDA.git"

  needs :cxx11

  depends_on "gettext"
  # needs `set_escdelay`, which isn't present in system ncurses before 10.6
  depends_on "homebrew/dupes/ncurses" if MacOS.version < :snow_leopard

  def install
    args = %W[
      NATIVE=osx RELEASE=1
      CXX=#{ENV.cxx} LD=#{ENV.cxx} CXXFLAGS=#{ENV.cxxflags}
    ]

    args << "CLANG=1" if ENV.compiler == :clang

    system "make", *args

    # no make install, so we have to do it ourselves
    libexec.install "cataclysm", "data"
    inreplace "cataclysm-launcher" do |s|
      s.change_make_var! 'DIR', libexec
    end
    bin.install "cataclysm-launcher" => "cataclysm"
  end
end
