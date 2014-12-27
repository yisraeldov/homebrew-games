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
    url "https://github.com/minetest/minetest/archive/0.4.11.tar.gz"
    sha1 "8af33253e0ac3a2c43d8127462e51461f9761343"

    resource "minetest_game" do
      url "https://github.com/minetest/minetest_game.git", :tag => "0.4.11"
    end
  end

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    cellar :any
    sha1 "758d0b5b49d7b7702432b3e54c4dc2072ef2890b" => :yosemite
    sha1 "e85aa444266fc409fbed9b519500608b97530295" => :mavericks
    sha1 "d3cfbce8047d765b9a2231a67e48df1e7bbafeca" => :mountain_lion
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
