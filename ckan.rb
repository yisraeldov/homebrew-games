class MonoDependency < Requirement
  fatal true
  default_formula "mono"
  satisfy { which("mono") }
end

class Ckan < Formula
  homepage "https://github.com/KSP-CKAN/CKAN/"
  url "https://github.com/KSP-CKAN/CKAN/releases/download/v1.6.14/ckan.exe", :using => :nounzip
  version "1.6.14"
  sha256 "21619df57bdff0aa030109ab7d8d94309a4041e8bbd689f111550eb41151d63f"

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
