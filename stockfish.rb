require "formula"

class Stockfish < Formula
  homepage "http://stockfishchess.org/"
  url "http://stockfish.s3.amazonaws.com/stockfish-6-src.zip"
  sha1 "a2d630c991d13bc5533c72896421eff14e4faa6a"
  head "https://github.com/official-stockfish/Stockfish.git"

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
