require 'formula'

class Ski < Formula
  url 'http://www.catb.org/~esr/ski/ski-6.8.tar.gz'
  homepage 'http://catb.org/~esr/ski/'
  sha1 '500c3ebff28dfe2b7a4c9c4c4690c0dea7a3e32a'

  def install
    bin.install "ski"
    man6.install "ski.6"
  end
end
