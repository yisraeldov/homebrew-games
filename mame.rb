class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  stable do
    url "https://github.com/mamedev/mame/archive/mame0163.tar.gz"
    version "0.163"
    sha256 "6be1536f0c8470764aead9a32f8b5d9fd7979040b402ec337cb47f73deaa68b1"

    # FIXME: only for clang build error on 0.163
    patch do
      url "https://github.com/mamedev/mame/commit/bc23c001b5dff4b271fc480c55d56785e9e3fa10.diff"
      sha256 "0541c65a7354125d59303ada00b13f9754af4acf0844ac1145c3cb648cfb6cf7"
    end
  end

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha256 "539179c770ae68e337538453a8904e1a81e1c68b13c0c15169f741f7b677b84b" => :yosemite
    sha256 "c0458449dc41dd5eaf696420b862654d680e20d846ac17282dd93123cf2e19d7" => :mavericks
    sha256 "67b585482e5abba94913b78b8092de3725d07eac2124cfcb3bbd8400d2ab4462" => :mountain_lion
  end

  depends_on "sdl2"

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = (MacOS.prefer_64_bit? ? "1" : "0")

    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cxx}",
                   "TARGET=mame", "SUBTARGET=mame"

    if MacOS.prefer_64_bit?
      bin.install "mame64" => "mame"
    else
      bin.install "mame"
    end
    man6.install "src/osd/sdl/man/mame.6"
  end

  test do
    system "#{bin}/mame", "-help"
  end
end
