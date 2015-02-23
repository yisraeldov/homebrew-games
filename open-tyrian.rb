class OpenTyrian < Formula
  homepage "https://code.google.com/p/opentyrian/"
  url "http://www.camanis.net/opentyrian/releases/opentyrian-2.1.20130907-src.tar.gz"
  sha1 "c5b97aea3931db6889acb639e59e619162b05183"

  depends_on "sdl"
  depends_on "sdl_net"

  resource "data" do
    url "http://sites.google.com/a/camanis.net/opentyrian/tyrian/tyrian21.zip"
    sha1 "29827de99c92cdba7ac8d8b1307776c8f473cd44"
  end

  def install
    libexec.install resource("data")

    system "make release"
    libexec.install "opentyrian"
    (bin/"opentyrian").write <<-END.undent
      #!/bin/bash
      "#{libexec}/opentyrian" --data="#{libexec}" "$@"
    END
  end

  def caveats
    "Save games will be put in ~/.opentyrian"
  end
end
