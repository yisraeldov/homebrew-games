require "formula"

class Minetest < Formula
  homepage "http://www.minetest.net/"

  depends_on :x11
  depends_on "cmake" => :build
  depends_on "irrlicht"
  depends_on "jpeg"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "luajit" => :recommended
  depends_on "freetype" => :recommended
  depends_on "gettext" => :recommended
  depends_on "leveldb" => :optional
  depends_on "redis" => :optional

  head do
    url "https://github.com/minetest/minetest.git"

    resource "minetest_game" do
      url "https://github.com/minetest/minetest_game.git", :branch => "master"
    end
  end

  stable do
    url "https://github.com/minetest/minetest/archive/0.4.13.tar.gz"
    sha256 "d77ee70c00a923c3ed2355536997f064a95143d0949a7fc92d725d079edef9f7"

    resource "minetest_game" do
      url "https://github.com/minetest/minetest_game/archive/0.4.13.tar.gz"
      sha256 "8d1671484fcd62936ae15bf6a2f9fd9863a8fb010bdf8902ba63977395f3b613"
    end
  end

  bottle do
    revision 1
    sha256 "aa99f6dd204472671291622f339385369a047560ea5083d5b5e359a4e9362f92" => :yosemite
    sha256 "531c767b5c13969525e318d599250342a78703b97f0838db35e548d96a7dc281" => :mavericks
    sha256 "24573fdef24471d4f00f293c512c97c9342c02173d6bcc2fbd4edddae49cb980" => :mountain_lion
  end

  def install
    (buildpath/"games/minetest_game").install resource("minetest_game")

    args = std_cmake_args - %w{-DCMAKE_BUILD_TYPE=None}
    args << "-DCMAKE_BUILD_TYPE=Release" << "-DBUILD_CLIENT=1" << "-DBUILD_SERVER=0"
    args << "-DENABLE_REDIS=1" if build.with? "redis"
    args << "-DENABLE_LEVELDB=1" if build.with? "leveldb"
    args << "-DENABLE_FREETYPE=1" << "-DCMAKE_EXE_LINKER_FLAGS='-L#{Formula["freetype"].opt_lib}'" if build.with? "freetype"
    args << "-DENABLE_GETTEXT=1" << "-DCUSTOM_GETTEXT_PATH=#{Formula["gettext"].opt_prefix}" if build.with? "gettext"

    system "cmake", ".", *args
    system "make", "package"
    system "unzip", "minetest-*-osx.zip"
    prefix.install "minetest.app"
  end

  def caveats; <<-EOS.undent
      Put additional subgames and mods into "games" and "mods" folders under
      "~/Library/Application Support/minetest/", respectively (you may have
      to create those folders first).

      If you would like to start the Minetest server from a terminal, run
      "/Applications/minetest.app/Contents/MacOS/minetest --server".
    EOS
  end
end
