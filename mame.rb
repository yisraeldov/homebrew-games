class Mame < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0159.tar.gz"
  sha1 "c68b620b04c6da4fe6776a13cdc0aed776a1bed0"
  version "0.159"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha1 "764ff8dcfffb974e94b0827354501fcd3cb20445" => :yosemite
    sha1 "d1043661f80c8becded6b286a757a131e8abbd60" => :mavericks
    sha1 "15ba90ce6e8507572884370aa14b1ac125528fe2" => :mountain_lion
  end

  depends_on "sdl2"

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = (MacOS.prefer_64_bit? ? "1" : "0")
    ENV["LTO"] = "1" if (ENV.compiler == :clang && MacOS.version > :lion) || ENV.compiler =~ /^gcc-(4\.[6-9])$/

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
