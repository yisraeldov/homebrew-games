class Xboard < Formula
  homepage "https://www.gnu.org/software/xboard/"
  url "http://ftpmirror.gnu.org/xboard/xboard-4.7.3.tar.gz"
  mirror "https://ftp.gnu.org/gnu/xboard/xboard-4.7.3.tar.gz"
  sha256 "7fd0b03f53dad57c587bc3438459612e2455534f715cfb0e637b6290f34cbeaa"

  bottle do
    sha256 "b01bdebeec0ca39e2d34acf08a210e4c22843f7b541a1a04d5a777dff95341de" => :yosemite
    sha256 "ababbd0b0d60bf6571cfe8b7e18e620dc654b8a82d22bd877b850c00a93851c4" => :mavericks
    sha256 "68355a1ab17eeaf7d1efb0c3bcdeaefe5ac754f2b33908bb9771fb88b3f2d80b" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "fairymax" => :recommended
  depends_on "gettext"
  depends_on "cairo"
  depends_on "librsvg"
  depends_on :x11

  def install
    args = ["--prefix=#{prefix}",
            "--x-include=#{MacOS::X11.include}",
            "--x-lib=#{MacOS::X11.lib}",
            "--disable-zippy"]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"xboard", "--help"
  end
end
