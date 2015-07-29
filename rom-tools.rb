class RomTools < Formula
  desc "Tools for Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0164.tar.gz"
  version "0.164"
  sha256 "01e9b3c03c7a379a0aecea50415c9ba687d8f0af282a8447027d02d279055a81"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "72368ee98a38f733485603626d12e4c79478c11f581d473977c9856ef692909c" => :yosemite
    sha256 "b8b55af265043b210d7f3680f93b2242f53c367c852112961cbb0752a62a1dc0" => :mavericks
    sha256 "2ba79cf6cbc99e0f197a2082788ed044f6e4964d010b00842b0a2782192c25ba" => :mountain_lion
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
