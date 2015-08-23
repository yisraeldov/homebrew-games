class Atari800 < Formula
  desc "Atari 8-bit machine emulator"
  homepage "http://atari800.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/atari800/atari800/3.1.0/atari800-3.1.0.tar.gz"
  sha256 "901b02cce92ddb0b614f8034e6211f24cbfc2f8fb1c6581ba0097b1e68f91e0c"

  head do
    url "git://git.code.sf.net/p/atari800/source"
    depends_on "autoconf" => :build
  end

  depends_on "sdl"
  depends_on "libpng"

  def install
    chdir "src" do
      system "./autogen.sh" if build.head?
      system "./configure", "--prefix=#{prefix}",
                            "--disable-sdltest"
      system "make", "install"
    end
  end

  test do
    assert_equal "Atari 800 Emulator, Version #{version}",
                 shell_output("#{bin}/atari800 -v", 3).strip
  end
end
