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

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha256 "d5448287d4c3fae3c67e528067dd81465e102c483e05e11fc95dd51ee447efc4" => :yosemite
    sha256 "071d9e8b87007e9c447c649c8e2554ef79eeb899792e6d5d48308bd626c166b9" => :mavericks
    sha256 "6d30325a2245db52cfab2020f41f501537651d6d9d2a8dcd5a43d3a226c24be5" => :mountain_lion
  end

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
