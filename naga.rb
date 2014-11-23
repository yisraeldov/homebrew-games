require "formula"

class Naga < Formula
  homepage "https://github.com/anayjoshi/naga/"
  url "https://github.com/anayjoshi/naga/archive/naga-v1.0.tar.gz"
  sha1 "9ba4aaf827521222b4b43fb736614c4c7b7bfc8e"

  def install
    bin.mkpath()
    system "make", "install", "INSTALL_PATH=#{bin}/naga"
  end

end
