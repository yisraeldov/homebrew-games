class Ume < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0159.tar.gz"
  sha1 "c68b620b04c6da4fe6776a13cdc0aed776a1bed0"
  version "0.159"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha1 "61b3ca6ad1c5a780e5f716d4b13f5e39d523b69f" => :mavericks
    sha1 "1c1793d00682bbaa95e23009ecf0373f74ea3b1d" => :mountain_lion
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
