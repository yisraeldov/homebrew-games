require 'formula'

class StoneSoup < Formula
  homepage 'http://crawl.develz.org/'
  url 'https://downloads.sourceforge.net/project/crawl-ref/Stone%20Soup/0.15.2/stone_soup-0.15.2.tar.xz'
  sha1 'fb9bec3f4adbb3e8cc60e6ddc77cd63f23654b81'

  bottle do
    sha1 "ffda406e7326f61980800f2c09686cc6f817606d" => :yosemite
    sha1 "7632c4211d0a6e0e606b6ce91e12f0128c3903b5" => :mavericks
    sha1 "9c9f1b441fb8972b65dc8d2d48db52ade96b9f3e" => :mountain_lion
  end

  depends_on 'xz' => :build

  def install
    # Numerous template issues building under libc++
    ENV.libstdcxx

    cd "source" do
      # The makefile has trouble locating the developer tools for
      # CLT-only systems, so we set these manually. Reported upstream:
      # https://crawl.develz.org/mantis/view.php?id=7625
      #
      # On 10.9, stone-soup will try to use xcrun and fail due to an empty
      # DEVELOPER_DIR
      devdir = MacOS::Xcode.prefix.to_s
      devdir += '/' if MacOS.version >= :mavericks && !MacOS::Xcode.installed?

      system "make", "install", "prefix=#{prefix}", "DATADIR=data/",
        "DEVELOPER_DIR=#{devdir}", "SDKROOT=#{MacOS.sdk_path}",
        # stone-soup tries to use `uname -m` to determine build -arch,
        # which is frequently wrong on OS X
        "SDK_VER=#{MacOS.version}", "MARCH=#{MacOS.preferred_arch}"
    end
  end
end
