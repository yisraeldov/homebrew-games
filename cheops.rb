class Cheops < Formula
  desc "CHEss OPponent Simulator"
  homepage "http://en.nothingisreal.com/wiki/CHEOPS"
  url "http://files.nothingisreal.com/software/cheops/cheops-1.2.tar.bz2"
  sha256 "60aabc9f193d62028424de052c0618bb19ee2ccfa6a99b74a33968eba4c8abad"

  def install
    # Avoid ambiguous std::move issue with libc++
    ENV.libstdcxx

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/cheops", "--version"
  end
end
