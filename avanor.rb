require 'formula'

class Avanor < Formula
  url 'https://downloads.sourceforge.net/project/avanor/avanor/0.5.8/avanor-0.5.8-src.tar.bz2'
  homepage 'http://avanor.sourceforge.net/'
  sha1 '5685ca96a203a7f7ada733dc34b18faab440d189'

  # Upstream fix for clang: http://sourceforge.net/p/avanor/code/133/
  patch :p0 do
    url "https://gist.githubusercontent.com/mistydemeo/64f47233ee64d55cb7d5/raw/c1847d7e3a134e6109ad30ce1968919dd962e727/avanor-clang.diff"
    sha1 "f2b83c1ff5f2ad45ee19b663232f65b0d1238372"
  end

  def install
    system "make", "DATA_DIR=#{share}/avanor/", "CC=#{ENV.cxx}", "LD=#{ENV.cxx}"
    bin.install "avanor"
    (share+"avanor").install "manual"
  end
end
