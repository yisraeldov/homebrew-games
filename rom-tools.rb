class RomTools < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0159.tar.gz"
  sha1 "c68b620b04c6da4fe6776a13cdc0aed776a1bed0"
  version "0.159"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    cellar :any
    sha1 "adf2108028943db26719454cc0c8dc2ca6865e07" => :yosemite
    sha1 "4e4e34e7edac3477b3416f1d81f8ac385c07be47" => :mavericks
    sha1 "2f46e461f675e79dd2d1b77cab87b39c9009e6c8" => :mountain_lion
  end

  depends_on "sdl2"

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = (MacOS.prefer_64_bit? ? "1" : "0")
    ENV["LTO"] = "1" if ENV.compiler == :clang or ENV.compiler =~ /^gcc-(4\.[6-9])$/

    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cxx}", "tools"
    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cxx}", "TARGET=ldplayer"

    bin.install %W[
      chdman jedutil ldresample ldverify nltool pngcmp regrep romcmp src2html
      srcclean testkeys unidasm
    ]
    bin.install "split" => "rom-split"
    if MacOS.prefer_64_bit?
      bin.install "ldplayer64" => "ldplayer"
    else
      bin.install "ldplayer"
    end
    %W[chdman jedutil ldplayer ldresample ldverify romcmp testkeys].each do |manfile|
      man1.install "src/osd/sdl/man/#{manfile}.1"
    end
  end
end
