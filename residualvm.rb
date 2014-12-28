class Residualvm < Formula
  homepage "http://www.residualvm.org"
  url "https://github.com/residualvm/residualvm/archive/0.1.1.tar.gz"
  sha1 "93e25e28c7954488238840afbddaea559e566b9e"
  head "https://github.com/residualvm/residualvm.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    sha1 "9cee3053b323ba7730f9eedf19a426b8f5276634" => :yosemite
    sha1 "9ea0f992d35c0ee5ebdfcda1e9ee1d687b0474f9" => :mavericks
    sha1 "c8709305b4db83603fd822f9665ace6ec8cb0588" => :mountain_lion
  end

  depends_on "sdl"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
