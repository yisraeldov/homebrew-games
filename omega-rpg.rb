class OmegaRpg < Formula
  desc "The classic Roguelike game"
  homepage "http://www.alcyone.com/max/projects/omega/"
  url "http://www.alcyone.com/binaries/omega/omega-0.80.2-src.tar.gz"
  sha256 "60164319de90b8b5cae14f2133a080d5273e5de3d11c39df080a22bbb2886104"

  bottle do
    sha256 "1c0b199b608f8f3e4544243743049ffd334d26680cc372adf1c9c4aeb0420f55" => :yosemite
    sha256 "25bef4995836f8d1e2f66a1daafe0220a050c419e30ebf6dffbdfd567fc2ac5c" => :mavericks
    sha256 "5f492f394cbef8f1674cb5aa25a30e946a42288ba40e16958aae1789110b5568" => :mountain_lion
  end

  def install
    # Set up our target folders
    inreplace "defs.h", "#define OMEGALIB \"./omegalib/\"", "#define OMEGALIB \"#{libexec}/\""

    # Don't alias CC; also, don't need that ncurses include path
    # Set the system type in CFLAGS, not in makefile
    # Remove an obsolete flag
    inreplace "Makefile" do |s|
      s.remove_make_var! ["CC", "CFLAGS", "LDFLAGS"]
    end

    ENV.append_to_cflags "-DUNIX -DSYSV"

    system "make"

    # 'make install' is weird, so we do it ourselves
    bin.install "omega"
    libexec.install Dir["omegalib/*"]
  end
end
