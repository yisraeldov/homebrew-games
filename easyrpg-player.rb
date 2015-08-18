class EasyrpgPlayer < Formula
  desc "RPG Maker 2000/2003 games interpreter"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/Player/archive/0.3.tar.gz"
  sha256 "5c1201a36c555d80b8f30af758b74e60314f0f35fe084fe785b39ead7e2eff49"
  head "https://github.com/EasyRPG/Player.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost" => :build
  depends_on "liblcf"
  depends_on "libpng"
  depends_on "freetype"
  depends_on "pixman"
  depends_on "sdl2"
  depends_on "sdl2_mixer" => "with-libvorbis"

  def install
    system "autoreconf", "-i"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/easyrpg-player", "-v"
  end
end
