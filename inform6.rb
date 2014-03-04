require 'formula'

class Inform6 < Formula
  homepage 'http://www.inform-fiction.org/inform6.html'
  url 'http://ifarchive.flavorplex.com/if-archive/infocom/compilers/inform6/source/inform-6.32.1.tar.gz'
  sha1 '251cf057ddbf750a286802d2cfbccf5e80e25295'

  head do
    url 'https://github.com/DavidGriffith/inform6unix.git'

    depends_on :autoconf
    depends_on :automake
    depends_on :libtool
  end

  def patches
    unless build.head?
      # Fixes case-insensitivity issue that removes critical inform6 library files
      # https://github.com/DavidGriffith/inform6unix/pull/1 (fixed in HEAD)
      "https://gist.github.com/ziz/f2c0554ab0fefffab54b/raw/inform6unix-6.32.1.patch"
    end
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
