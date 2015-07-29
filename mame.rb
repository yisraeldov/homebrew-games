class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0164.tar.gz"
  version "0.164"
  sha256 "01e9b3c03c7a379a0aecea50415c9ba687d8f0af282a8447027d02d279055a81"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "03c8c00fb3f3091fb7bf508cd53bbbb715e34ac3b5f745f27a70f8b3cca8ab32" => :yosemite
    sha256 "94685ff1bad20b424f3f9bfa6cfac73f9a938aa8c80b5129def2592f179931c1" => :mavericks
    sha256 "1ecb32b9e6a014d87c321420bbda325223dfaac04467dfa72e1e2a26a6ee1483" => :mountain_lion
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
