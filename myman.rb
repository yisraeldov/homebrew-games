require "formula"

class Myman < Formula
  homepage "http://myman.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/myman/myman-cvs/myman-cvs-2009-10-30/myman-wip-2009-10-30.tar.gz"
  sha1 "41240e96945aabe2f9c6519aeaf512c3664e4ec5"

  depends_on "coreutils" => :build
  depends_on "gnu-sed" => :build
  depends_on "homebrew/dupes/groff" => :build

  def install
    ENV["RMDIR"] = "grmdir"
    ENV["SED"] = "gsed"
    ENV["INSTALL"] = "ginstall"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/myman", "-k"
  end
end
