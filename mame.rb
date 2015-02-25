class Mame < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0158.tar.gz"
  sha1 "c9f880e619c23290bc655542b5eebbc127596663"
  version "0.158"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha1 "944f2356be591fce21ab46a9835f78cf59de00a0" => :yosemite
    sha1 "f7da246db11d200675d403ad8d030970a1ddafa0" => :mavericks
    sha1 "94db4a29f1ffd38b063b6073eebe46333c8e9211" => :mountain_lion
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
