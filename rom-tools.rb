class RomTools < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0160.tar.gz"
  sha1 "506c49be812d12a04913b46acac2aed2025df1ff"
  version "0.160"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha256 "be5b2390e63a6f86bb7021afc119d74f40c0a3c051399d0beccf748216bc0550" => :yosemite
    sha256 "5ac067f43b03e6abcfcb248e081f9b24a8bb7516a7c08a1bdcd5c06604c88384" => :mavericks
    sha256 "d52fb8f6b058044b7503a04002888d36b9438e6a89245aa4335fe443f497e867" => :mountain_lion
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
