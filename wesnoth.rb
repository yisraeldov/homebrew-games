class Wesnoth < Formula
  homepage "http://www.wesnoth.org/"
  url "https://downloads.sourceforge.net/project/wesnoth/wesnoth-1.12/wesnoth-1.12.2/wesnoth-1.12.2.tar.bz2"
  sha256 "1f4f76e5fd0ce175a3eb7b9855aff7a58dc75899c534d7653d97ac9fd4fe798b"

  head "https://github.com/wesnoth/wesnoth.git"

  devel do
    url "https://downloads.sourceforge.net/project/wesnoth/wesnoth/wesnoth-1.13.0/wesnoth-1.13.0.tar.bz2"
    sha256 "68fc1f3e147c73b9eb3622a157e272d3f5f286acb3c5043dc1bfa7f7fb8cb912"
  end

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    sha256 "6cceadef75e97dce80f23b6dd537117c22ad8c70c4fffc60b1f3bf626d7a78e4" => :yosemite
    sha256 "227f920fc3bfffd1ec97d73289516880fa6f3a041c809aca52a1a75a4caa7f9f" => :mavericks
    sha256 "788803a5d90371e3e622f9469014062a520ea7e3e2bb0e9573ce1192baf53744" => :mountain_lion
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
