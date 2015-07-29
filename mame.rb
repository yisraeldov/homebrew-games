class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0164.tar.gz"
  version "0.164"
  sha256 "01e9b3c03c7a379a0aecea50415c9ba687d8f0af282a8447027d02d279055a81"
  head "https://github.com/mamedev/mame.git"

  bottle do
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
