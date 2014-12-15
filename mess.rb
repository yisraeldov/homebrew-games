require "formula"

class Mess < Formula
  homepage "http://www.mess.org/"
  url "https://github.com/mamedev/mame/archive/mame0156.tar.gz"
  sha1 "9cda662385c0b168ca564dab0fb1e839065f6a01"
  version "0.156"

  head "https://github.com/mamedev/mame.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    cellar :any
    sha1 "0f73d765cdb7ada1c032b8dea51bfb584abf1383" => :yosemite
    sha1 "1d70b67b8a47b58b38e5be508a6f925e57e78256" => :mavericks
    sha1 "3926b6f11f591d766e33f8221dd83f7983ae6e20" => :mountain_lion
  end

  depends_on "sdl2"

  # Fix for Cocoa framework linking and sdl-config path
  # It's been upstreamed, so remove from the next release
  # https://github.com/mamedev/mame/pull/60
  patch do
    url "https://github.com/mbcoguno/mame/commit/5d8dc09b12ea7d5576ef92e3e14a1db3654ff810.diff"
    sha1 "76c0f11f225968a10c0f024c55607e9f09634825"
  end

  def install
    ENV["MACOSX_USE_LIBSDL"] = "1"
    ENV["PTR64"] = MacOS.prefer_64_bit? ? "1" : "0"

    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cxx}",
                   "TARGET=mess", "SUBTARGET=mess"

    if MacOS.prefer_64_bit?
      bin.install "mess64" => "mess"
    else
      bin.install "mess"
    end
  end
end
