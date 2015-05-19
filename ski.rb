class Ski < Formula
  url "http://www.catb.org/~esr/ski/ski-6.9.tar.gz"
  homepage "http://catb.org/~esr/ski/"
  sha256 "d0f2fd7770a63319340fab8ee275c6221dff0e0e7fe488f2298f567583902d37"

  head do
    url "git://thyrsus.com/repositories/ski.git"
    depends_on "xmlto" => :build
  end

  def install
    if build.head?
      ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
      system "make"
    end
    bin.install "ski"
    man6.install "ski.6"
  end
end
