class RomTools < Formula
  desc "Tools for Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0163.tar.gz"
  version "0.163"
  sha256 "6be1536f0c8470764aead9a32f8b5d9fd7979040b402ec337cb47f73deaa68b1"

  head "https://github.com/mamedev/mame.git"

  # FIXME: only for clang build error on 0.163
  stable do
    patch do
      url "https://github.com/mamedev/mame/commit/bc23c001b5dff4b271fc480c55d56785e9e3fa10.diff"
      sha256 "0541c65a7354125d59303ada00b13f9754af4acf0844ac1145c3cb648cfb6cf7"
    end
  end

  bottle do
    cellar :any
    sha256 "5d3cf58071a602b2bf8ce98c07e81b4ffadc2d15d041e9d3bd65a17c334d6326" => :yosemite
    sha256 "1f069229616687470483632576c208414342950a8447f372669a5d8e4e327793" => :mavericks
    sha256 "f37ff245b8e5ff0d2123e3219f8bc670fbfac01ee7e8e8c79789f30692724c59" => :mountain_lion
  end

  depends_on "sdl2"

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = (MacOS.prefer_64_bit? ? "1" : "0")

    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cxx}", "TARGET=ldplayer", "TOOLS=1"

    bin.install %W[
      castool chdman floptool imgtool jedutil ldresample ldverify nltool pngcmp
      regrep romcmp src2html srcclean testkeys unidasm
    ]
    bin.install "split" => "rom-split"
    if MacOS.prefer_64_bit?
      bin.install "ldplayer64" => "ldplayer"
    else
      bin.install "ldplayer"
    end
    man1.install Dir["src/osd/sdl/man/*.1"]
  end

  test do
    system "#{bin}/ldplayer", "-help"
  end
end
