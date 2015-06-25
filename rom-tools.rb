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
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha256 "41dff32ae2a7622546390b62024cdc8dfc1d82625b28eaf7d8ac8e0c09634a7a" => :yosemite
    sha256 "341e9e6f93050048f25910e03a9821c8eaca560d39901b77084d45c4c043e2bf" => :mavericks
    sha256 "874609bcf9410a77955bcfde2e2eb3991c78d28dd07da917781903bb5534c7b0" => :mountain_lion
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
