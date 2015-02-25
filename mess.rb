class Mess < Formula
  homepage "http://www.mess.org/"
  url "https://github.com/mamedev/mame/archive/mame0158.tar.gz"
  sha1 "c9f880e619c23290bc655542b5eebbc127596663"
  version "0.158"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha1 "9e964f1dffbc39423b28cb8620082de336ea3cde" => :yosemite
    sha1 "d9bda37c8afddb2ca7cbeff15c9f0833d741ff44" => :mavericks
    sha1 "d8ce1177c8f6c0e4d814f995a03b62828fa42dec" => :mountain_lion
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
