class Ballerburg < Formula
  desc "Castle combat game"
  homepage "http://baller.tuxfamily.org/"
  url "http://download.tuxfamily.org/baller/ballerburg-1.2.0.tar.gz"
  sha256 "0625f4b213c1180f2cb2179ef2bc6ce35c7e99db2b27306a8690c389ceac6300"
  head "http://git.tuxfamily.org/baller/baller.git"

  depends_on "cmake" => :build
  depends_on "sdl"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
