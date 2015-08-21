class Fairymax < Formula
  desc "AI for playing Chess variants"
  homepage "http://www.chessvariants.org/index/msdisplay.php?itemid=MSfairy-max"
  url "http://hgm.nubati.net/git/fairymax.git", :tag => "4.8V", :revision => "b12e1192005c781f64ed9c25c9825d20384d2468"
  version "4.8V"
  head "http://hgm.nubati.net/git/fairymax.git"

  def install
    system "make", "all",
                   "INI_F=#{pkgshare}/fmax.ini",
                   "INI_Q=#{pkgshare}/qmax.ini"
    bin.install "fairymax", "shamax", "maxqi"
    pkgshare.install Dir["data/*.ini"]
    man6.install "fairymax.6.gz"
  end

  test do
    (testpath/"test").write <<-EOS.undent
      hint
      quit
    EOS
    system "#{bin}/fairymax < test"
  end
end
