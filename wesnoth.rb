class Wesnoth < Formula
  homepage "http://www.wesnoth.org/"
  head "https://github.com/wesnoth/wesnoth.git"
  url "https://downloads.sourceforge.net/project/wesnoth/wesnoth-1.12/wesnoth-1.12.1/wesnoth-1.12.1.tar.bz2"
  sha256 "70404764370db05e496a4e033e09c26cdc47fa6558271d803a44c4ebb7b6efe8"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    sha256 "7ad78744ea8d85ab4b96d10e6cfe521ddfce43bb08b6763fbe864dc21dfd8464" => :yosemite
    sha256 "ab92ebdca61c1022914580d1dd154cb5a1be0b392505716cfd80cbee7f4ccfbe" => :mavericks
    sha256 "e36e784cd1da06dc5582e9555e41c7a551f18f7239c643cef6236ee02c644ca3" => :mountain_lion
  end

  option "with-ccache", "Speeds recompilation, convenient for beta testers"
  option "with-debug", "Build with debugging symbols"

  depends_on "scons" => :build
  depends_on "gettext" => :build
  depends_on "fribidi"
  depends_on "boost"
  depends_on "libpng"
  depends_on "fontconfig"
  depends_on "cairo"
  depends_on "pango"

  if OS.linux?
    # On linux, x11 driver is needed by the windowing and clipboard code
    depends_on "sdl" => "with-x11"
  else
    depends_on "sdl"
  end

  depends_on "sdl_image" # Must have png support
  depends_on "sdl_mixer" => "with-libvorbis" # The music is in .ogg format
  depends_on "sdl_net"
  depends_on "sdl_ttf"

  depends_on "ccache" => :optional

  def install
    args = %W[prefix=#{prefix} docdir=#{doc} mandir=#{man} fifodir=#{var}/run/wesnothd gettextdir=#{Formula["gettext"].opt_prefix}]
    args << "OS_ENV=true"
    args << "install"
    args << "wesnoth"
    args << "wesnothd"
    args << "-j#{ENV.make_jobs}"
    args << "ccache=true" if build.with? "ccache"
    args << "build=debug" if build.with? "debug"

    scons *args
  end

  test do
    system bin/"wesnoth", "-p", share/"wesnoth/data/campaigns/tutorial/", testpath
  end
end
