require 'formula'

class Stormlib < Formula
  homepage "http://www.zezula.net/en/mpq/stormlib.html"
  url "https://github.com/ladislav-zezula/StormLib/archive/v9.00a.tar.gz"
  sha1 "74bdda9309cce208d4982c9a1f5d740d246a9755"
  version "9.00a"
  head "https://github.com/ladislav-zezula/StormLib.git"

  depends_on "cmake" => :build

  patch :DATA

  def install
    system "cmake", "CMakeLists.txt", "-DWITH_STATIC=YES", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <stdio.h>
      #include <StormLib.h>

      int main(int argc, char *argv[]) {
        printf("%s", STORMLIB_VERSION_STRING);
        return 0;
      }
    EOS
    system ENV.cc, "-o", "test", "test.c"
    system "./test", "-v"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3b22069..03ed2c6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -288,7 +288,6 @@ if(WITH_STATIC)
 endif()

 if(APPLE)
-    set_target_properties(storm PROPERTIES FRAMEWORK true)
     set_target_properties(storm PROPERTIES PUBLIC_HEADER "src/StormLib.h src/StormPort.h")
     set_target_properties(storm PROPERTIES LINK_FLAGS "-framework Carbon")
 endif()
