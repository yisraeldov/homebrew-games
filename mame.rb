class Mame < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0160.tar.gz"
  sha1 "506c49be812d12a04913b46acac2aed2025df1ff"
  version "0.160"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha256 "8f39fe4f6ad9db996c593d2203a7002bf57beb3cb6b7136fd72d3bc72f8468be" => :yosemite
    sha256 "d4a71a98ead64f5b8382a35d0d4b0986240b9b74f9322ec264a1b0b29b2cd1f1" => :mavericks
    sha256 "d1275ee0229aa5c295d461a32dfeddfa4b72ea8d80d315261ff3bf5f15163732" => :mountain_lion
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
