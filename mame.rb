class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  stable do
    url "https://github.com/mamedev/mame/archive/mame0163.tar.gz"
    version "0.163"
    sha256 "6be1536f0c8470764aead9a32f8b5d9fd7979040b402ec337cb47f73deaa68b1"

    # FIXME: only for clang build error on 0.163
    patch do
      url "https://github.com/mamedev/mame/commit/bc23c001b5dff4b271fc480c55d56785e9e3fa10.diff"
      sha256 "0541c65a7354125d59303ada00b13f9754af4acf0844ac1145c3cb648cfb6cf7"
    end
  end

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha256 "ca307eb321b8d925a8bcb9816ab9d7a4668c38297246d5dcd878cac10ce26dbe" => :yosemite
    sha256 "96c931a9f378177527931f6dc6f4ee122d8a471689b6c60f4b3a6417877b1823" => :mavericks
    sha256 "566f4bedf490d1ced0f4b4dc5e57d55a217dc507b2640ef4962aa841c93c3401" => :mountain_lion
  end

  depends_on "sdl2"

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = (MacOS.prefer_64_bit? ? "1" : "0")

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
