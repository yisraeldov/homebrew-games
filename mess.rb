class Mess < Formula
  homepage "http://www.mess.org/"
  url "https://github.com/mamedev/mame/archive/mame0161.tar.gz"
  sha256 "f7db934676e90d0d7f2b678ccf32e580417c754dd33117ec683560956c2130b9"
  version "0.161"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha256 "ce59293e74daff4072d82e49f2e4e3ae69d66ff8a50c23c8c5a0ebf8d3d708bf" => :yosemite
    sha256 "66dc0edd54b1cf7e6d46b7c0f36ba715fba688277a1a282f1cca0319eac25869" => :mavericks
    sha256 "3e5c78395957997645d51fc69e45b4ff45b1ab724084bba899ad850778377acd" => :mountain_lion
  end

  depends_on "sdl2"

  # Use OpenGL extensions for non-framework SDL 2 environment.
  # Upstream: <https://github.com/mamedev/mame/pull/170>
  patch do
    url "https://github.com/mbcoguno/mame/commit/05f71a27f9.diff"
    sha256 "d7c82d97cc9367226b44bcd174b98ce56f96b034f12a0af7cae1da76065a947c"
  end

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = MacOS.prefer_64_bit? ? "1" : "0"

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
