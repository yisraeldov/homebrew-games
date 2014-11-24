require "formula"

class Mame < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0155.tar.gz"
  sha1 "9f4e92491bf56f2ea76f136daa69dbf88e589b71"
  version "0.155"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    cellar :any
    sha1 "c9198093fd5ca8d90313f471277c8297c68321be" => :yosemite
    sha1 "e712fc84e2b971121d24f895057bec56457b687f" => :mavericks
    sha1 "f612228ac79d3987de4e0062751e98111c3e095c" => :mountain_lion
  end

  depends_on "sdl"

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = (MacOS.prefer_64_bit? ? "1" : "0")
    ENV["LTO"] = "1" if ENV.compiler == :clang or ENV.compiler =~ /^gcc-(4\.[6-9])$/

    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cxx}",
                   "TARGET=mame", "SUBTARGET=mame"

    if MacOS.prefer_64_bit?
      bin.install "mame64" => "mame"
    else
      bin.install "mame"
    end
  end
end
