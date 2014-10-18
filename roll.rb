require 'formula'

class Roll < Formula
  homepage 'http://matteocorti.ch/software/roll.html'
  url 'http://matteocorti.ch/software/roll/roll-2.0.2.tar.gz'
  sha1 '27899218903b6f2f435990f6aebdefe753f3a28a'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  test do
    system "#{bin}/roll", "1d6"
  end
end
