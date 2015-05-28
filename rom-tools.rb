class RomTools < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0162.tar.gz"
  sha256 "97b5154177cf7fa862f72be0a5a1241d4560a44bc00c2ac1785f0ae706deb899"
  version "0.162"

  head "https://github.com/mamedev/mame.git"

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
end
