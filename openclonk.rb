class Openclonk < Formula
  head "https://github.com/openclonk/openclonk", :using => :git
  homepage "http://www.openclonk.org"
  url "https://github.com/openclonk/openclonk/archive/v6.1.tar.gz"
  sha256 "4e2e6cefedd4a13523593b285af23b530caa3a98ff02ac4adb215cf32889cb94"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha256 "3e61a12dca0998d1c0a78466569abb325c32a26549034b1569cb187f479082d0" => :yosemite
    sha256 "76e83695bfa80b4387004961a6693d555993a4a603cdcd386908edfbd195592a" => :mavericks
    sha256 "f31c5f4100c5bd8ab22ca8d25dbf52df5b40ffbaed1567f1cb325547fcafcf2a" => :mountain_lion
  end

  depends_on :macos => :mountain_lion
  depends_on "cmake" => :build
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "freetype"
  depends_on "glew"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "boost"
  depends_on "freealut"

  needs :cxx11

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    system "true"
  end
end
