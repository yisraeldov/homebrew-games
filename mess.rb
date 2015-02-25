class Mess < Formula
  homepage "http://www.mess.org/"
  url "https://github.com/mamedev/mame/archive/mame0158.tar.gz"
  sha1 "c9f880e619c23290bc655542b5eebbc127596663"
  version "0.158"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    cellar :any
    sha1 "4c3b32a691eafd982e510149a43dd970a9ebdc67" => :yosemite
    sha1 "f7fe9072c5ed0e69c525fab77f65b63878634ca6" => :mavericks
    sha1 "6328918f90dea35dc2c5718d4fb6b37b8c6ad190" => :mountain_lion
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
