class Mame < Formula
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0162.tar.gz"
  sha256 "97b5154177cf7fa862f72be0a5a1241d4560a44bc00c2ac1785f0ae706deb899"
  version "0.162"

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
