class MonoDependency < Requirement
  fatal true
  default_formula "mono"
  satisfy { which("mono") }
end

class Ckan < Formula
  homepage "https://github.com/KSP-CKAN/CKAN/"
  url "https://github.com/KSP-CKAN/CKAN/releases/download/v1.6.23/ckan.exe", :using => :nounzip
  version "1.6.23"
  sha256 "6707f650b60d95f2a077012f0bcfffb8fef47b7607848d400b19d915907b143f"

  depends_on MonoDependency

  def install
    (libexec/"bin").install "ckan.exe"
    (bin/"ckan").write <<-EOS.undent
      #!/bin/sh
      exec mono "#{libexec}/bin/ckan.exe" "$@"
    EOS
  end

  test do
    system bin/"ckan", "version"
  end
end
