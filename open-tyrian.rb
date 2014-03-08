require 'formula'

class OpenTyrian < Formula
  url 'http://opentyrian.googlecode.com/hg/', :revision => '9ddcd06e48'
  homepage 'http://code.google.com/p/opentyrian/'
  version '20091122'

  depends_on 'sdl'
  depends_on 'sdl_net'

  resource 'data' do
    url 'http://sites.google.com/a/camanis.net/opentyrian/tyrian/tyrian21.zip'
    sha1 '29827de99c92cdba7ac8d8b1307776c8f473cd44'
  end

  def install
    libexec.install resource('data')

    system "make release"
    libexec.install "opentyrian"
    (bin+'opentyrian').write <<-END.undent
      #!/bin/bash
      "#{libexec}/opentyrian" --data="#{libexec}" "$@"
    END
  end

  def caveats
    "Save games will be put in ~/.opentyrian"
  end
end
