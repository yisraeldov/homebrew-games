require 'formula'

class Frotz < Formula
  url 'https://downloads.sourceforge.net/project/frotz/frotz/2.43/frotz-2.43d.tar.gz'
  homepage 'http://frotz.sourceforge.net/'
  sha1 'e0986ca35a7f8c7dade1dc534701e883eee8b5ae'
  head 'git://frotz.git.sourceforge.net/gitroot/frotz/frotz'

  def install
    inreplace "Makefile" do |s|
      s.remove_make_var! %w[CC OPTS]
      s.change_make_var! "PREFIX", prefix
      s.change_make_var! "CONFIG_DIR", etc
      s.change_make_var! "MAN_PREFIX", share
    end

    system "make frotz"
    system "make install"
  end
end
