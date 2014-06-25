require 'formula'

class Unnethack < Formula
  homepage 'http://sourceforge.net/apps/trac/unnethack/'
  url 'https://downloads.sourceforge.net/project/unnethack/unnethack/5.1.0/unnethack-5.1.0-20131208.tar.gz'
  sha1 '8535f69eca4f510a29dd1bf869aa55d6dea4664d'

  head 'https://github.com/UnNetHack/UnNetHack.git'

  # directory for temporary level data of running games
  skip_clean "var/unnethack/level"

  option "with-lisp-graphics", "Enable lisp graphics (play in Emacs)"
  option "with-curses-graphics", "Enable curses graphics (play with fanciness)"

  def install
    # crashes when using clang and gsl with optimizations
    # https://github.com/mxcl/homebrew/pull/8035#issuecomment-3923558
    ENV.no_optimization

    # directory for version specific files that shouldn't be deleted when
    # upgrading/uninstalling
    version_specific_directory = "#{var}/unnethack/#{version}"

    args = [ "--prefix=#{prefix}",
             "--with-owner=#{`id -un`}", "--with-group=admin",
             # common xlogfile for all versions
             "--enable-xlogfile=#{var}/unnethack/xlogfile",
             "--with-bonesdir=#{version_specific_directory}/bones",
             "--with-savesdir=#{version_specific_directory}/saves",
             "--enable-wizmode=#{`id -un`}" ]

    args << "--enable-lisp-graphics" if build.with? 'lisp-graphics'

    args << "--enable-curses-graphics" if build.with? 'curses-graphics'

    system "./configure", *args
    ENV.j1 # Race condition in make
    system "make install"
  end
end
