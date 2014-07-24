require "formula"

class Nethack4 < Formula
  homepage "http://nethack4.org"
  url "http://nethack4.org/media/releases/nethack4-4.3.0-beta1-source.tar.gz"
  sha1 "1f1b11cf5748b58926b354fae763e80df4f63372"
  version "4.3.0-beta1"

  # These two patches remove the use of realtime POSIX signals on OS X,
  # which doesn't provide that feature
  # http://trac.nethack4.org/ticket/514; fixed upstream, will be in next release
  patch :p0 do
    url "http://trac.nethack4.org/changeset/d63ae4a465546f4edd32b9438109c67269b901d3/?format=diff&new=d63ae4a465546f4edd32b9438109c67269b901d3"
    sha1 "75514db0827ce58bf278d0b2611fe867864e1a36"
  end

  # Patch 1: Removes realtime signals from another file, too (see above)
  # Adapted from upstream commit
  # Patch 2: Fix logfile flush call
  # http://trac.nethack4.org/ticket/529; fixed upstream, will be in next release
  patch :DATA

  # Ensures _XOPEN_SOURCE is set, needed to include ucontext.h
  # http://trac.nethack4.org/ticket/513; fixed upstream, will be in next release
  patch :p0 do
    url "http://trac.nethack4.org/changeset/6859f7e4ad6957d66fc48780b2932347539a33a0/?format=diff&new=6859f7e4ad6957d66fc48780b2932347539a33a0"
    sha1 "98b4f33c3d97760d3fa5bf3136bc46ff0dc7717e"
  end

  # Also define _DARWIN_C_SOURCE to ensure all needed types are available
  # http://trac.nethack4.org/ticket/525; fixed upstream, will be in next release
  patch :p0 do
    url "http://trac.nethack4.org/changeset/4a8488b79319f9267c60472cfe6e6d3c561c275a/?format=diff&new=4a8488b79319f9267c60472cfe6e6d3c561c275a"
    sha1 "0180deb14a0b11bbd8b203e3de7d2b4d246c848a"
  end

  # Fix static link on windowprocs
  # Upstream commit: http://trac.nethack4.org/changeset/258e15564575f73b5fbbcf8f833a44c530ac8d77/
  patch :p1 do
    url "https://gist.githubusercontent.com/mistydemeo/b8aa85b8095aca2efd95/raw/98de73a3d897159d4ece761f42b6385d42e9f180/windowclient.diff"
    sha1 "ba577f5eeb3da388c9abdbdabc06bbf29b229eff"
  end

  def install
    # buildsystem hardcodes some paths: http://trac.nethack4.org/ticket/531
    inreplace "aimake" do |s|
      s.gsub! "staterootdir => 'spath:/var'", "staterootdir => 'spath:#{var}'"
      s.gsub! "gamesbindir => '$installdir/games'", "gamesbindir => '$installdir/bin'"
    end

    mkdir "build"
    cd "build" do
      system "../aimake", "--with=jansson", "--without=gui",
        "-i", prefix, "--directory-layout=fhs_unmanaged"
    end
  end
end

__END__
diff --git a/libnethack/src/allmain.c b/libnethack/src/allmain.c
index 3902ffc..7b39eed 100644
--- a/libnethack/src/allmain.c
+++ b/libnethack/src/allmain.c
@@ -51,7 +51,7 @@ nh_lib_init(const struct nh_window_procs *procs, char **paths)
 
     u.uhp = 1;  /* prevent RIP on early quits */
 
-#ifdef UNIX
+#ifdef AIMAKE_BUILDOS_linux
     /* SIGRTMIN+{1,2} are used by the lock monitoring code. This means that we
        could end up with spurious signals due to race conditions after a game
        exits or when reading save files in the main menu of the client. In such
diff --git a/libnethack/src/log.c b/libnethack/src/log.c
index 9cb6fad..d01fc69 100644
--- a/libnethack/src/log.c
+++ b/libnethack/src/log.c
@@ -2318,7 +2318,7 @@ log_uninit(void)
     if (program_state.logfile > -1)
         change_fd_lock(program_state.logfile, TRUE, LT_NONE, 0);
 
-#ifdef UNIX
+#ifdef AIMAKE_BUILDOS_linux
     flush_logfile_watchers();
 #endif
 
