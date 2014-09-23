require "formula"
require "etc"

class Bastet < Formula
  homepage "http://fph.altervista.org/prog/bastet.html"
  url "http://fph.altervista.org/prog/files/bastet-0.41.tgz"
  sha1 "644a0f76adedef84946159520c1639ff0c6c47ec"

  patch :p1 do
    url "http://fph.altervista.org/prog/files/bastet-0.41-osx-patch.diff"
    sha1 "bf38253d07889025c05440a77b4a498dfd952a2c"
  end

  def install
    inreplace "Makefile" do |s|
      s.change_make_var! "BIN_PREFIX", "#{bin}/"
      s.change_make_var! "DATA_PREFIX", "#{var}/"
      s.change_make_var! "GAME_USER", Etc.getpwuid.name
    end
    system "make", "all"

    # for some reason, these aren't created automatically
    bin.mkpath
    var.mkpath

    system "make", "install"

    # the makefile doesn't install the manpage
    man6.install "bastet.6"
  end
end
