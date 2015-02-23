class Residualvm < Formula
  homepage "http://www.residualvm.org"
  url "https://github.com/residualvm/residualvm/archive/0.2.1.tar.gz"
  sha1 "b39b14678b87ebd917d91b1a6e411446ac5cfef4"
  head "https://github.com/residualvm/residualvm.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    sha1 "564a86dacaad4f809686f111ea7ca9fc342ccf39" => :yosemite
    sha1 "2037f7546c6f07b663b0433fed05c1190ec0a519" => :mavericks
    sha1 "493c255b9e041085624e3e2570f7cbe29547654b" => :mountain_lion
  end

  depends_on "sdl"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
