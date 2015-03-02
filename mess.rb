class Mess < Formula
  homepage "http://www.mess.org/"
  url "https://github.com/mamedev/mame/archive/mame0159.tar.gz"
  sha1 "c68b620b04c6da4fe6776a13cdc0aed776a1bed0"
  version "0.159"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha1 "dd6dfd33e569d2ab468fea1ef59caa044b1e284a" => :yosemite
    sha1 "15a3b9edc45ae22748cf201feb5227f86b1ff54c" => :mavericks
    sha1 "a7242058940f227761d5221de2e2b0ca8cd9c065" => :mountain_lion
  end

  depends_on "sdl2"

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = MacOS.prefer_64_bit? ? "1" : "0"
    ENV["LTO"] = "1" if (ENV.compiler == :clang && MacOS.version > :lion) || ENV.compiler =~ /^gcc-(4\.[6-9])$/

    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cxx}",
                   "TARGET=mess", "SUBTARGET=mess"

    if MacOS.prefer_64_bit?
      bin.install "mess64" => "mess"
    else
      bin.install "mess"
    end
    man6.install "src/osd/sdl/man/mess.6"
  end

  test do
    system "#{bin}/mess", "-help"
  end
end
