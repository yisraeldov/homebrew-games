class Fuego < Formula
  homepage "http://fuego.sourceforge.net/"
  url "http://svn.code.sf.net/p/fuego/code/trunk", :revision => 1981
  version "1.1.SVN"

  bottle do
    sha1 "baada923a390e85d861e17f52ef5828a7b46507d" => :yosemite
    sha1 "de717af5d96a517ece0f7567ce5c20f270a53790" => :mavericks
    sha1 "cb3d147498cf47304dbffb7b3c68c66c9ac6b69c" => :mountain_lion
  end

  head "http://svn.code.sf.net/p/fuego/code/trunk"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "boost"

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
