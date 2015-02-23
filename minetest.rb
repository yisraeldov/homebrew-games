require "formula"

class Minetest < Formula
  homepage "http://www.minetest.net/"

  option "with-gettext", "Enable Gettext support"
  option "with-freetype", "Use brewed version of Freetype"
  option "without-client", "Build without client components"
  option "without-server", "Build without server components"

  depends_on :x11
  depends_on "cmake" => :build
  depends_on "irrlicht"
  depends_on "jpeg"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "luajit"
  depends_on "gettext" => :optional
  depends_on "freetype" => :optional

  head do
    url "https://github.com/minetest/minetest.git"

    resource "minetest_game" do
      url "https://github.com/minetest/minetest_game.git", :branch => "master"
    end
  end

  stable do
    url "https://github.com/minetest/minetest/archive/0.4.12.tar.gz"
    sha1 "1ea404afd37ca3496b6ad8a8c6ebc28a317fe54c"

    resource "minetest_game" do
      url "https://github.com/minetest/minetest_game.git", :tag => "0.4.12"
    end
  end

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha1 "f2bb3bc988d893bbcb94efa5f22c18045ed570bd" => :yosemite
    sha1 "284fb796ccd3c38b051eaf8aeb013d30b66df20d" => :mavericks
    sha1 "0e7e1942b99ef96a11735b6be6918b7247e4cf17" => :mountain_lion
  end

  def install
    (buildpath/"games/minetest_game").install resource("minetest_game")

    args = std_cmake_args - %w{-DCMAKE_BUILD_TYPE=None}
    args << '-DCMAKE_BUILD_TYPE=Release'
    args << "-DENABLE_FREETYPE=1" if build.with? "freetype"
    args << "-DBUILD_CLIENT=0" if build.without? "client"
    args << "-DBUILD_SERVER=0" if build.without? "server"
    args << "-DENABLE_GETTEXT=1" << "-DCUSTOM_GETTEXT_PATH=#{Formula["gettext"].opt_prefix}}" if build.with? "gettext"

    # Their CMake cannot create simple app bundle now, but we may use "make
    # package" to create .dmg package with bundle inside and then copy bundle
    # from its tmp directory. Thus, we need to specify where to find it.
    args << "-DCPACK_TOPLEVEL_TAG="
    system "cmake", ".", *args
    # Still need to replace CPACK_PACKAGE_FILE_NAME via config
    inreplace "CPackConfig.cmake", /\(CPACK_PACKAGE_FILE_NAME .+\)/, '(CPACK_PACKAGE_FILE_NAME "minetest")'

    system "make", "package"
    prefix.install "_CPack_Packages/Bundle/minetest/minetest.app"
  end
end
