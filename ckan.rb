class MonoDependency < Requirement
  fatal true
  default_formula "mono"
  satisfy { which("mono") }
end

class Ckan < Formula
  homepage "https://github.com/KSP-CKAN/CKAN/"
  # CKAN releases a raw .exe file
  url "https://github.com/KSP-CKAN/CKAN/releases/download/v1.6.11/ckan.exe", :using => :nounzip
  version "1.6.11"
  sha256 "95ea198e702c145ab21ad30e7e4e73a40bae4d86d87c5e03ef150cbf7b505f23"

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
