class Xboard < Formula
  homepage 'https://www.gnu.org/software/xboard/'
  url 'http://ftpmirror.gnu.org/xboard/xboard-4.7.3.tar.gz'
  mirror 'https://ftp.gnu.org/gnu/xboard/xboard-4.7.3.tar.gz'
  sha1 'dab9a69f3c8afd70a7a2e5e31f48d31fd9fbbabb'

  depends_on 'pkg-config' => :build
  depends_on 'fairymax' => :recommended
  depends_on 'gettext'
  depends_on 'cairo'
  depends_on 'librsvg'
  depends_on :x11

  def install
    args = ["--prefix=#{prefix}",
            "--x-include=#{MacOS::X11.include}",
            "--x-lib=#{MacOS::X11.lib}",
            "--disable-zippy"]

    system "./configure", *args
    system "make"
    system "make install"
  end
end
