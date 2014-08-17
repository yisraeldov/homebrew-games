require 'formula'

class Openttd < Formula
  homepage 'http://www.openttd.org/'
  url 'http://binaries.openttd.org/releases/1.4.2/openttd-1.4.2-source.tar.gz'
  sha1 '23da37d74ce7187a0d5d70c2324f18f72e6f0cc6'

  head 'git://git.openttd.org/openttd/trunk.git'

  depends_on 'lzo'
  depends_on 'xz'
  depends_on 'pkg-config' => :build

  resource 'opengfx' do
    url 'http://bundles.openttdcoop.org/opengfx/releases/0.5.1/opengfx-0.5.1.zip'
    sha1 'f2700bc86ae49d2cdadc5b56d8abb7d49b4f2167'
  end

  resource 'opensfx' do
    url 'http://bundles.openttdcoop.org/opensfx/releases/0.2.3/opensfx-0.2.3.zip'
    sha1 'bfbfeddb91ff32a58a68488382636f38125c48f4'
  end

  resource 'openmsx' do
    url 'http://bundles.openttdcoop.org/openmsx/releases/0.3.1/openmsx-0.3.1.zip'
    sha1 'e9c4203923bb9c974ac67886bd00b7090658b961'
  end

  def patches
    p = {
      :p0 => [
        # Ensures a deployment target is not set on 10.9;
        # TODO report this upstream
        'https://trac.macports.org/export/117147/trunk/dports/games/openttd/files/patch-config.lib-remove-deployment-target.diff'
      ]
    }
  end

  def install
    system "./configure", "--prefix-dir=#{prefix}"
    system "make bundle"

    (buildpath/'bundle/OpenTTD.app/Contents/Resources/data/opengfx').install resource('opengfx')
    (buildpath/'bundle/OpenTTD.app/Contents/Resources/data/opensfx').install resource('opensfx')
    (buildpath/'bundle/OpenTTD.app/Contents/Resources/gm/openmsx').install resource('openmsx')

    prefix.install 'bundle/OpenTTD.app'
  end

  def caveats; <<-EOS.undent
      OpenTTD.app installed to: #{prefix}
      If you have access to the sound and graphics files from the original
      Transport Tycoon Deluxe, you can install them by following the
      instructions in section 4.1 of #{prefix}/readme.txt
    EOS
  end
end
