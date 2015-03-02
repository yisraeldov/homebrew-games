class Ppsspp < Formula
  homepage "http://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git", :tag => "v1.0.1"
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha1 "9ec048258882fb2ea2f71661f6ccf4bcd4373ff6" => :yosemite
    sha1 "cfd18d4a6a6d2e07daa74d6a626d9614c6f201c3" => :mavericks
    sha1 "b6f556ce03d30c0c7ab57c21663a929ebdb9e0dd" => :mountain_lion
  end

  depends_on "cmake" => :build
  depends_on "sdl2"
  depends_on "ffmpeg"

  def install
    # Build type will be set to "Release" by default
    args = std_cmake_args
    args.delete "-DCMAKE_BUILD_TYPE=None"

    # Use brewed FFmpeg rather than precompiled binaries in the repo
    ffmpeg = Formula["ffmpeg"]
    args << "-DFFMPEG_BUILDDIR=#{ffmpeg.opt_prefix}"
    inreplace "CMakeLists.txt" do |s|
      s.gsub! "STATIC IMPORTED", "SHARED IMPORTED"
      s.gsub! %r{\${FFMPEG_BUILDDIR}\/lib.*\/(lib.*)\.a}, "${FFMPEG_BUILDDIR}/lib/\\1.dylib"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      prefix.install "PPSSPPSDL.app"
      bin.write_exec_script "#{prefix}/PPSSPPSDL.app/Contents/MacOS/PPSSPPSDL"
    end
  end
end
