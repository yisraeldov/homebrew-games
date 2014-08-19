require "formula"

class ArxLibertatis < Formula
  homepage "https://arx-libertatis.org/"
  url "https://arx-libertatis.org/files/arx-libertatis-1.1.2.tar.xz"
  sha1 "3b14a55553c564fd33caafb3a5bdb2d328e1fde8"

  option "without-innoextract", "Build without arx-install-data"

  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "glm" => :build
  depends_on "freetype"
  depends_on "glew"
  depends_on "innoextract" => :recommended
  depends_on "sdl"

  def install
    mkdir "build" do
     system "cmake", "..", *std_cmake_args
     system "make"
     system "make install"
    end
  end

  def caveats;
    if build.with? "innoextract"; then <<-EOS.undent
      This package only contains the Arx Libertatis binary, not the game data.
      To play Arx Fatalis you will need to obtain the game from GOG.com and install
      the game data with:

        arx-install-data /path/to/setup_arx_fatalis.exe
      EOS
    end
  end
end
