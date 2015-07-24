require "formula"

class Stockfish < Formula
  homepage "http://stockfishchess.org/"
  url "http://stockfish.s3.amazonaws.com/stockfish-6-src.zip"
  sha1 "a2d630c991d13bc5533c72896421eff14e4faa6a"
  head "https://github.com/official-stockfish/Stockfish.git"

  bottle do
    cellar :any
    sha256 "622bacb36395cb7ccdb83510c354292d954aa655201fdc506185de99b18de75d" => :yosemite
    sha256 "f02a0eaa017869d57cdb713ab8e20c70122ed17fa60f8add1f2db1933b843ec2" => :mavericks
    sha256 "6dda7191589eb57f3145681eeb6868dc528d0a3ccd217213177378c57f6a3873" => :mountain_lion
  end

  def install
    if Hardware::CPU.features.include? :popcnt
      arch = "x86-64-modern"
    else
      arch = Hardware::CPU.ppc? ? "ppc" : "x86"
      arch += "-" + (MacOS.prefer_64_bit? ? "64" : "32")
    end

    cd "src" do
      system "make", "build", "ARCH=#{arch}"
      bin.install "stockfish"
    end
  end

  test do
    system "#{bin}/stockfish", "go", "depth", "20"
  end
end
