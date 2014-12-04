class Mame < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0157.tar.gz"
  sha1 "cac1ccb4194715be63dd4d4754a575b9e1c11ea3"
  version "0.157"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    cellar :any
    sha1 "80ddf4088a09db73e30e898412379a4e19a772a8" => :yosemite
    sha1 "fa7ce6374dd8e9a97fa07801ab3d5cd7341094bf" => :mavericks
    sha1 "1d7e69beff269c0dae1228ff6dfc8700d78e9fe9" => :mountain_lion
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
end
