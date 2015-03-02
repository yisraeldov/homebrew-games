class Ume < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0159.tar.gz"
  sha1 "c68b620b04c6da4fe6776a13cdc0aed776a1bed0"
  version "0.159"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha1 "2bf12725b28257832a65c3df2ccab4518511b30c" => :yosemite
    sha1 "4344cafb83d3c51185df99588353d39133198dc0" => :mavericks
    sha1 "512b83dd3e8001e622efca1c8d080e23b028c28d" => :mountain_lion
  end

  depends_on "sdl2"

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = MacOS.prefer_64_bit? ? "1" : "0"
    ENV["LTO"] = "1" if (ENV.compiler == :clang && MacOS.version > :lion) || ENV.compiler =~ /^gcc-(4\.[6-9])$/

    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cxx}", "TARGET=ume"

    if MacOS.prefer_64_bit?
      bin.install "ume64" => "ume"
    else
      bin.install "ume"
    end
  end

  test do
    system "#{bin}/ume", "-help"
  end
end
