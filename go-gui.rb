require 'formula'

class GoGui < Formula
  homepage 'http://gogui.sourceforge.net'
  url 'https://downloads.sourceforge.net/project/gogui/gogui/1.4.9/gogui-1.4.9.zip'
  sha1 'b4c402fa42ea054e251642e56a5da0be890c24e5'

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
