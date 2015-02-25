class Ume < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0158.tar.gz"
  sha1 "c9f880e619c23290bc655542b5eebbc127596663"
  version "0.158"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    cellar :any
    sha1 "7ebb3549d4da3bd2eb8dd7b7664e07080905db21" => :yosemite
    sha1 "b5b99840681e125a96e8d3e29c7ff884720b3732" => :mavericks
    sha1 "25b44824b5f6fcdd515f7ad6b12ef81a5b2f5a75" => :mountain_lion
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
