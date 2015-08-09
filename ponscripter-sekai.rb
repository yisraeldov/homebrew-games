class PonscripterSekai < Formula
  desc "NScripter-like visual novel engine"
  homepage "https://github.com/sekaiproject/ponscripter-fork"
  url "https://github.com/sekaiproject/ponscripter-fork/archive/v0.0.6.tar.gz"
  sha256 "888a417808fd48f8f55da42c113b04d61396a1237b2b0fed2458e804b8ddf426"
  head "https://github.com/sekaiproject/ponscripter-fork.git"

  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer" => ["with-libvorbis", "with-smpeg2"]
  depends_on "libvorbis"
  depends_on "smpeg2"
  depends_on "freetype"

  def install
    # Disable building man pages
    inreplace "configure", /.*install-man.*/, ""

    system "./configure", "--prefix=#{prefix}",
                          "--unsupported-compiler"
    system "make", "install"
  end

  test do
    system "#{bin}/ponscr", "-v"
  end
end
