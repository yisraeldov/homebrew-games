class MonoDependency < Requirement
  fatal true
  default_formula "mono"
  satisfy { which("mono") }
end

class Ckan < Formula
  homepage "https://github.com/KSP-CKAN/CKAN/"
  # CKAN releases a raw .exe file
  url "https://github.com/KSP-CKAN/CKAN/releases/download/v1.6.6/ckan.exe", :using => :nounzip
  version "1.6.6"
  sha256 "61a4f22666772ef8d5bcbf8ebc68797879fa2017042b0096636894a20e0cb0a0"

  depends_on MonoDependency

  def install
    (libexec/"bin").install "ckan.exe"
    # The usual method for running ckan.exe is `mono ckan.exe arg1 arg2 ...`
    # This is a wrapper script for aliasing it as `ckan arg1 arg2 ...` into the PATH
    (bin/"ckan").write <<-EOS.undent
      #!/bin/sh
      exec mono "#{libexec}/bin/ckan.exe" "$@"
    EOS
  end

  test do
    system bin/"ckan", "version"
  end
end
