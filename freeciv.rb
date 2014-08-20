require 'formula'

class Freeciv < Formula
  homepage 'http://freeciv.wikia.com'
  url 'https://downloads.sourceforge.net/project/freeciv/Freeciv%202.3/2.3.1/freeciv-2.3.1.tar.bz2'
  sha1 '9d9ee9f48f4c945fc6525139d340443d5a25aac4'
  head 'svn://svn.gna.org/svn/freeciv/trunk'

  option 'disable-nls', 'Disable NLS support'

  depends_on 'pkg-config' => :build
  depends_on 'sdl'
  depends_on 'sdl_image'
  depends_on 'sdl_mixer'
  depends_on :x11
  depends_on 'gettext' unless build.include? 'disable-nls'

  def install
    args = ["--disable-debug", "--disable-dependency-tracking",
            "--prefix=#{prefix}"]

    if build.include? 'disable-nls'
      args << "--disable-nls"
    else
      gettext = Formula["gettext"]
      args << "CFLAGS=-I#{gettext.include}"
      args << "LDFLAGS=-L#{gettext.lib}"
    end

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/freeciv-server", "-v"
  end
end
