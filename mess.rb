class Mess < Formula
  homepage "http://www.mess.org/"
  url "https://github.com/mamedev/mame/archive/mame0160.tar.gz"
  sha1 "506c49be812d12a04913b46acac2aed2025df1ff"
  version "0.160"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha256 "a6f944ba99f67ddbe952046f366e22e938752e608e1a681813b8b3cbee373aa1" => :yosemite
    sha256 "7b4d2ec40ce12583951f1cfa31afdc8830fca43a09b666f1780c3e21111d803f" => :mavericks
    sha256 "7fe153d0847d4bafd32fac06321ebdc61bb9e4dddbb0a6cb18fb589c1011436b" => :mountain_lion
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
