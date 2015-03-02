class Ppsspp < Formula
  homepage "http://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git", :tag => "v1.0.1"
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    cellar :any
    sha1 "aac8e32c6fece2f96cc435a251dca0e37b0bc1ff" => :yosemite
    sha1 "fd11a895ddbe25bd32d49d0bf2bcd942c17cc7f2" => :mavericks
    sha1 "66a032027e962f82e245ad35fd9f49e448368f64" => :mountain_lion
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
