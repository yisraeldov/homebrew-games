require 'formula'

class Avanor < Formula
  url 'https://downloads.sourceforge.net/project/avanor/avanor/0.5.8/avanor-0.5.8-src.tar.bz2'
  homepage 'http://avanor.sourceforge.net/'
  sha1 '5685ca96a203a7f7ada733dc34b18faab440d189'

  def install
    inreplace 'Makefile' do |s|
      s.gsub! "CC = gpp", "CC = cpp"
      s.gsub! "LD = gpp", "LD = cpp"
    end

    system "make", "DATA_DIR=#{share}/avanor/"
    bin.install "avanor"
    (share+"avanor").install "manual"
  end
end
