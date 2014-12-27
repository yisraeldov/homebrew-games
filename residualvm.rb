class Residualvm < Formula
  homepage "http://www.residualvm.org"
  url "https://github.com/residualvm/residualvm/archive/0.1.1.tar.gz"
  sha1 "93e25e28c7954488238840afbddaea559e566b9e"
  head "https://github.com/residualvm/residualvm.git"

  depends_on "sdl"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
