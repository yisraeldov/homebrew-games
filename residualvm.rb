class Residualvm < Formula
  desc "3D graphic adventure game interpreter"
  homepage "http://residualvm.org"
  url "https://downloads.sourceforge.net/project/residualvm/residualvm/0.2.1/residualvm-0.2.1-sources.tar.bz2"
  sha256 "cd2748a665f80b8c527c6dd35f8435e718d2e10440dca10e7765574c7402d924"
  head "https://github.com/residualvm/residualvm.git"

  bottle do
    sha1 "564a86dacaad4f809686f111ea7ca9fc342ccf39" => :yosemite
    sha1 "2037f7546c6f07b663b0433fed05c1190ec0a519" => :mavericks
    sha1 "493c255b9e041085624e3e2570f7cbe29547654b" => :mountain_lion
  end

  option "with-all-engines", "Enable all engines (including broken or unsupported)"
  option "with-safedisc", "Enable SafeDisc decryption for Myst III"

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
    args << "--enable-safedisc" if build.with? "safedisc"
    system "./configure", *args
    system "make"
    system "make", "install"
    (share+"icons").rmtree
    (share+"pixmaps").rmtree
  end

  test do
    system "#{bin}/residualvm", "-v"
  end
end
