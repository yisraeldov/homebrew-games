class Residualvm < Formula
  homepage "http://www.residualvm.org"
  url "https://github.com/residualvm/residualvm/archive/0.2.1.tar.gz"
  sha1 "b39b14678b87ebd917d91b1a6e411446ac5cfef4"
  head "https://github.com/residualvm/residualvm.git"

  depends_on "sdl"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
