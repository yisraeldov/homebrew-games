require 'formula'

class Fairymax < Formula
  homepage 'http://home.hccnet.nl/h.g.muller/CVfairy.html'
  # contents are same with 4.8S release, just dos2unix for Makefile, *.c and data/* and repackaging
  url 'https://cavendishqi-chaos.googlecode.com/files/fairymax-4.8S.tar.gz'
  sha1 'e1ab6850c4f98a8a7ba85899608a84e09b30175d'

  # fix Makefile: change DESTDIR to fit with brew, directory detection and creation and etc
  patch do
    url "https://gist.github.com/liangqi/5469225/raw/f2672157782ca228f6336d0c76e25620d3039aac/Makefile.diff"
    sha1 "9aeabd93d4d6b151dea4e2dd0549b5d6d646fb6b"
  end

  def install
    system "make", "install", "DESTDIR=#{prefix}"
  end
end
