require 'formula'

class Netris < Formula
  # Official site is non-responsive - 3/19/2012 - @adamv
  homepage 'http://www.netris.org/'
  url 'ftp://ftp.netris.org/pub/netris/netris-0.52.tar.gz'
  mirror 'http://ftp.de.debian.org/debian/pool/main/n/netris/netris_0.52.orig.tar.gz'
  sha1 '5a51f68ccb6c09fbd3a940f57d0ded52c3d3a535'

  # Debian has been applying fixes and security patches, so let's re-use their work.
  # Also fixes case of "TERM=xterm-color256" which otherwise segfaults.
  def patches
    [
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/01_multi-games-with-scoring',
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/02_line-count-patch',
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/03_staircase-effect-fix',
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/04_robot-close-fixup',
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/05_init-static-vars',
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/06_curses.c-include-term.h',
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/07_curses.c-include-time.h',
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/08_various-fixes',
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/09_ipv6',
      'http://git.deb.at/w/pkg/netris.git/blob_plain/90991bd0137a2510f93ec126a8642f48eb3738be:/debian/patches/10_fix-memory-leak',
    ]
  end

  def install
    system "sh Configure"
    system "make"
    bin.install "netris"
  end
end
