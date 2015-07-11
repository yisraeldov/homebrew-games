class Wesnoth < Formula
  desc "Single- and multi-player turn-based strategy game"
  homepage "http://www.wesnoth.org/"
  url "https://downloads.sourceforge.net/project/wesnoth/wesnoth-1.12/wesnoth-1.12.4/wesnoth-1.12.4.tar.bz2"
  sha256 "bf525060da4201f1e62f861ed021f13175766e074a8a490b995052453df51ea7"

  head "https://github.com/wesnoth/wesnoth.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    sha256 "6cceadef75e97dce80f23b6dd537117c22ad8c70c4fffc60b1f3bf626d7a78e4" => :yosemite
    sha256 "227f920fc3bfffd1ec97d73289516880fa6f3a041c809aca52a1a75a4caa7f9f" => :mavericks
    sha256 "788803a5d90371e3e622f9469014062a520ea7e3e2bb0e9573ce1192baf53744" => :mountain_lion
  end

  devel do
    url "https://downloads.sourceforge.net/project/wesnoth/wesnoth/wesnoth-1.13.1/wesnoth-1.13.1.tar.bz2"
    sha256 "4423645f58eae3a22cdb94736a20181fbb3c2de3de36e20a70084b15b20337f2"
  end

  option "with-ccache", "Speeds recompilation, convenient for beta testers"
  option "with-debug", "Build with debugging symbols"

  depends_on "scons" => :build
  depends_on "gettext" => :build
  depends_on "ccache" => :optional
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
