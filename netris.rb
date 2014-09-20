require 'formula'

class Netris < Formula
  # Official site is non-responsive - 3/19/2012 - @adamv
  homepage 'http://www.netris.org/'
  url 'ftp://ftp.netris.org/pub/netris/netris-0.52.tar.gz'
  mirror 'http://ftp.de.debian.org/debian/pool/main/n/netris/netris_0.52.orig.tar.gz'
  sha1 '5a51f68ccb6c09fbd3a940f57d0ded52c3d3a535'

  # Debian has been applying fixes and security patches, so let's re-use their work.
  # Also fixes case of "TERM=xterm-color256" which otherwise segfaults.
  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/01_multi-games-with-scoring"
    sha1 "7c565db8d075e092437a4a6bdb7a787e64330943"
  end

  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/02_line-count-patch"
    sha1 "daaac151f0e91b3826dc9d3750888ed37d636ccf"
  end

  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/03_staircase-effect-fix"
    sha1 "1744fff85f14d03f994b6e9762f27d486e9bbc87"
  end

  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/04_robot-close-fixup"
    sha1 "a6082221bded98523155119ed6a9368f0f668a31"
  end

  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/05_init-static-vars"
    sha1 "a253dbe386b64c0d45b5f61cf364ecb457c766ad"
  end

  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/06_curses.c-include-term.h"
    sha1 "f2e36b43228750c5d7d66f2957ce1f85891b7deb"
  end

  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/07_curses.c-include-time.h"
    sha1 "bf141d80d454ac52aa2d87052f3caca5257b62c3"
  end

  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/08_various-fixes"
    sha1 "e9a0e8f7a5f29b468081f2700e49698b7b4da51a"
  end

  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/09_ipv6"
    sha1 "02ffef29f723017ce55036934f25f72a7d57ef1d"
  end

  patch do
    url "http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/10_fix-memory-leak"
    sha1 "d1b7d6949fc04b471adf5343293089d3dca4cfb6"
  end

  def install
    system "sh Configure"
    system "make"
    bin.install "netris"
  end
end
