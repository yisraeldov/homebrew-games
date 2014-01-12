require 'formula'

# Copies the subversion clone to a subdirectory, preserving the .svn metadata
# which is required for determining the release number.
#
class PuzzlesHeadDownloadStrategy < SubversionDownloadStrategy
  def stage
    safe_system 'cp', '-pR', "#{@clone}/", '.'
  end
end

class Puzzles < Formula
  homepage 'http://www.chiark.greenend.org.uk/~sgtatham/puzzles/'
  url 'svn://svn.tartarus.org/sgt/puzzles@10107', :using => PuzzlesHeadDownloadStrategy
  head 'svn://svn.tartarus.org/sgt/puzzles', :using => PuzzlesHeadDownloadStrategy

  depends_on 'halibut'

  def install
    ENV.deparallelize

    system "perl", "mkfiles.pl"
    system "make", "-d", "-f", "Makefile.osx", "all"
    prefix.install "Puzzles.app"
  end

  def caveats; <<-EOS
    Puzzles.app was installed in:
      #{opt_prefix}

    To symlink into ~/Applications, you can do:
      brew linkapps
    EOS
  end
end
