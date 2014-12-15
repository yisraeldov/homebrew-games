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
    url "https://github.com/minetest/minetest/archive/0.4.10.tar.gz"
    sha1 "06179ea793200236254105c5bc656c1e2e1fb1ef"

    resource "minetest_game" do
      url "https://github.com/minetest/minetest_game.git", :tag => "0.4.10"
    end

    # these patches wasn't backported to 0.4.10, so keep it until new stable
    patch do
      url "https://github.com/minetest/minetest/pull/1928.diff"
      sha1 "0640b82417a44ed1aeeb7dc8649184fe14e95e34"
    end

    patch do
      url "https://github.com/minetest/minetest/pull/1975.diff"
      sha1 "f867a9f73b046b23a1c3dd0e97c104cc98a66ea1"
    end

    # related to patch above, as resource because binary file cannot be patched :(
    resource "icns" do
      url "https://raw.githubusercontent.com/neoascetic/minetest/3b902fd574bfba74ebbd58369dce74162385b410/misc/minetest-icon.icns"
      sha1 "66a1fa2c2ecc3520b6b4b23621d739aff971ce76"
    end
  end

  def install
    (buildpath/"games/minetest_game").install resource("minetest_game")
    (buildpath/"misc").install resource("icns") if build.stable?

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
