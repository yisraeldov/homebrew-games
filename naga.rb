require "formula"

class Naga < Formula
  homepage "https://github.com/anayjoshi/naga/"
  url "https://github.com/anayjoshi/naga/archive/naga-v1.0.tar.gz"
  sha1 "9ba4aaf827521222b4b43fb736614c4c7b7bfc8e"

  bottle do
    cellar :any
    sha1 "6ca134f2efac554b07e770139c3c33f4df6feae6" => :yosemite
    sha1 "530bf68d68d32def280055ca3c07884b24c9538d" => :mavericks
    sha1 "89f602eae5136fb53ec8e816ae384ac8a181b1a1" => :mountain_lion
  end

  def install
    bin.mkpath()
    system "make", "install", "INSTALL_PATH=#{bin}/naga"
  end

end
