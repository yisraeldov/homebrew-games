class Openclonk < Formula
  homepage "http://www.openclonk.org"
  url "https://github.com/openclonk/openclonk/archive/v6.0.tar.gz"
  sha256 "1daa437a598f09375d85d0cd6cfb8655f285ae9f1939221cea2f587e531133ba"
  head "https://github.com/openclonk/openclonk", :using => :git

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

  patch do
    url "https://github.com/openclonk/openclonk/commit/5c9d687d67a5c159a07dabb385b236996f6de668.diff"
    sha256 "93c2698bf20cf8cf6c11cf6a128dd4841435efa47ca4ced06c2ace0e60f63481"
  end

  patch do
    url "https://github.com/openclonk/openclonk/commit/c82adb78537515c02368678e39942c4df61d7bd5.diff"
    sha256 "5736fb918002cb3a5cc096d00656664aa5ba944c7ca60a963bc8c6597328384b"
  end

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
