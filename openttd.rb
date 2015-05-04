class Openttd < Formula
  homepage "http://www.openttd.org/"
  url "http://binaries.openttd.org/releases/1.5.0/openttd-1.5.0-source.tar.xz"
  sha256 "cb2735c3c94709430c58eb4e8820cd5d26b1a17447c34ca8792bb3432a3f7c2d"

  head "git://git.openttd.org/openttd/trunk.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    sha256 "bf9d0c015c423c12ce937f09e69f435f8d46446735b665c333af874a09299a55" => :yosemite
    sha256 "2114a0425310d168ee2d93cb55e25364765c4c532be99a2c99ebbe9b5c7f2a81" => :mavericks
    sha256 "fb2541820550c54dcebdac93addfe07c84eb9c2c9069d3b97a5b57677483dfff" => :mountain_lion
  end

  depends_on "lzo"
  depends_on "xz"
  depends_on "pkg-config" => :build

  resource "opengfx" do
    url "http://bundles.openttdcoop.org/opengfx/releases/0.5.2/opengfx-0.5.2.zip"
    sha256 "19be61f1cb04cbb3cb9602f0b8eb6e6f56ecbefbfdd6e0e03f9579e5a5c1cbc8"
  end

  resource "opensfx" do
    url "http://bundles.openttdcoop.org/opensfx/releases/0.2.3/opensfx-0.2.3.zip"
    sha256 "3574745ac0c138bae53b56972591db8d778ad9faffd51deae37a48a563e71662"
  end

  resource "openmsx" do
    url "http://bundles.openttdcoop.org/openmsx/releases/0.3.1/openmsx-0.3.1.zip"
    sha256 "92e293ae89f13ad679f43185e83fb81fb8cad47fe63f4af3d3d9f955130460f5"
  end

  # Ensures a deployment target is not set on 10.9:
  # https://bugs.openttd.org/task/6295
  patch :p0 do
    url "https://trac.macports.org/export/117147/trunk/dports/games/openttd/files/patch-config.lib-remove-deployment-target.diff"
    sha256 "95c3d54a109c93dc88a693ab3bcc031ced5d936993f3447b875baa50d4e87dac"
  end

  def install
    system "./configure", "--prefix-dir=#{prefix}"
    system "make", "bundle"

    (buildpath/"bundle/OpenTTD.app/Contents/Resources/data/opengfx").install resource("opengfx")
    (buildpath/"bundle/OpenTTD.app/Contents/Resources/data/opensfx").install resource("opensfx")
    (buildpath/"bundle/OpenTTD.app/Contents/Resources/gm/openmsx").install resource("openmsx")

    prefix.install "bundle/OpenTTD.app"
  end

  def caveats; <<-EOS.undent
      OpenTTD.app installed to: #{prefix}
      If you have access to the sound and graphics files from the original
      Transport Tycoon Deluxe, you can install them by following the
      instructions in section 4.1 of #{prefix}/readme.txt
    EOS
  end

  test do
    File.executable? prefix/"OpenTTD.app/Contents/MacOS/openttd"
  end
end
