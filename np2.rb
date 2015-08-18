class Np2 < Formula
  desc "Neko Project 2: PC-9801 emulator"
  homepage "http://www.yui.ne.jp/np2/"
  url "http://amethyst.yui.ne.jp/svn/pc98/np2/tags/VER_0_84/", :using => :svn, :revision => "1735"
  sha256 "c21130b82dc1cd946c657598726d113891739343100aa63b3a15d9fb9e23eb68"
  head "http://amethyst.yui.ne.jp/svn/pc98/np2/trunk/", :using => :svn

  depends_on :xcode => :build
  depends_on "sdl2"
  depends_on "sdl2_ttf"

  def install
    sdl2 = Formula["sdl2"]
    sdl2_ttf = Formula["sdl2_ttf"]

    cd "sdl2/MacOSX" do
      # Use brewed library paths
      inreplace "np2sdl2.xcodeproj/project.pbxproj" do |s|
        s.gsub! "BAF84E4B195AA35E00183062", "//BAF84E4B195AA35E00183062"
        s.gsub! "HEADER_SEARCH_PATHS = (", "LIBRARY_SEARCH_PATHS = (\"$(inherited)\", #{sdl2.lib}, #{sdl2_ttf.lib}); HEADER_SEARCH_PATHS = (#{sdl2.include}/SDL2, #{sdl2.include}, #{sdl2_ttf.include},"
        s.gsub! "buildSettings = {", 'buildSettings ={ OTHER_LDFLAGS = "-lSDL2 -lSDL2_ttf";'
      end
      # Force to use Japanese TTF font
      inreplace "np2sdl2/compiler.h", "#define RESOURCE_US", ""
      # Always use current working directory
      inreplace "np2sdl2/main.m", "[pstrBundlePath UTF8String]", '"./"'

      xcodebuild "SYMROOT=build"
      bin.install "build/Release/np2sdl2.app/Contents/MacOS/np2sdl2" => "np2"
    end
  end

  def caveats; <<-EOS.undent
    A Japanese TTF file named `default.ttf` should be in the working directory.
    EOS
  end
end
