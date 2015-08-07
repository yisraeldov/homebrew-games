class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice/archive/2015-07-15-Release.tar.gz"
  version "2015-07-15"
  sha256 "2e9bdd48e196b8b4976e9de8f486044ac4517abe824edc1e8eb3bbb4ba3e9820"
  head "https://github.com/Cockatrice/Cockatrice.git"

  option "with-server", "Build `servatrice` for running game servers"

  depends_on "cmake" => :build
  depends_on "protobuf"

  fails_with :clang do
    build 503
    cause "Undefined symbols for architecture x86_64: google::protobuf"
  end

  if build.with? "server"
    depends_on "libgcrypt"
    depends_on "qt5" => "with-mysql"
  else
    depends_on "qt5"
  end

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DWITH_SERVER=ON" if build.with? "server"
      system "cmake", "..", *args
      system "make", "install"
      prefix.install Dir["release/*.app"]
    end
    doc.install Dir["doc/usermanual/*"]
  end

  test do
    (prefix/"cockatrice.app/Contents/MacOS/cockatrice").executable?
    (prefix/"oracle.app/Contents/MacOS/oracle").executable?
  end
end
