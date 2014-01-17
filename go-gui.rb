require 'formula'

class GoGui < Formula
  homepage 'http://gogui.sourceforge.net'
  url 'http://downloads.sourceforge.net/project/gogui/gogui/1.4.7/gogui-1.4.7.zip'
  sha1 'f9237e50594eafcb3d18e0b5238e32e28af72f1b'

  depends_on :ant

  def install
    inreplace "build.xml", "/Developer/Tools/SetFile", "/usr/bin/SetFile"
    system "ant", "gogui.app", "-Ddoc-uptodate=true"
    prefix.install 'build/GoGui.app'
  end

  def caveats; <<-EOS.undent
    GoGui.app installed to:
      #{prefix}
    Use `brew linkapps` to symlink into ~/Applications.
    EOS
  end
end
