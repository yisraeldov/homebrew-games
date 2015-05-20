class Nethack4 < Formula
  homepage "http://nethack4.org"
  url "http://nethack4.org/media/releases/nethack4-4.3-beta2.tar.gz"
  sha256 "b143a86b5e1baf55c663ae09c2663b169d265e95ac43154982296a1887d05f15"
  version "4.3.0-beta2"

  head "http://nethack4.org/media/nethack4.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    sha1 "bfe3bd2461289bb7064dd915128733e1692fce3c" => :yosemite
    sha1 "225b12566eda278271735f5f737e210d0afba302" => :mavericks
    sha1 "c8eb2ecd075280628e7c4e4f81afbf7afd83c477" => :mountain_lion
  end

  # Assumes C11 _Noreturn is available for clang:
  # http://trac.nethack4.org/ticket/568
  fails_with :clang do
    build 425
  end

  def install
    ENV.refurbish_args

    mkdir "build"
    cd "build" do
      system "../aimake", "--with=jansson", "--without=gui",
        "-i", prefix, "--directory-layout=prefix",
        "--override-directory", "staterootdir=#{var}"
    end
  end

  test do
    system "nethack4", "--version"
  end
end
