class Scummvm < Formula
  desc "Graphic adventure game interpreter"
  homepage "http://scummvm.org/"
  url "https://downloads.sourceforge.net/project/scummvm/scummvm/1.7.0/scummvm-1.7.0.tar.bz2"
  sha256 "d9ff0e8cf911afa466d5456d28fef692a17d47ddecfd428bf2fef591237c2e66"
  head "https://github.com/scummvm/scummvm.git"

  option "with-all-engines", "Enable all engines (including broken or unsupported)"

  depends_on "sdl"
  depends_on "libvorbis" => :recommended
  depends_on "mad" => :recommended
  depends_on "flac" => :recommended
  depends_on "libmpeg2" => :optional
  depends_on "jpeg" => :recommended
  depends_on "libpng" => :recommended
  depends_on "theora" => :recommended
  depends_on "faad2" => :recommended
  depends_on "fluid-synth" => :recommended
  depends_on "freetype" => :recommended

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-release
    ]
    args << "--enable-all-engines" if build.with? "all-engines"
    system "./configure", *args
    system "make"
    system "make", "install"
    (share+"pixmaps").rmtree
  end

  test do
    system "#{bin}/scummvm", "-v"
  end
end
