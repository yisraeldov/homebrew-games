require 'formula'

class Mupen64plus < Formula
  url 'https://mupen64plus.googlecode.com/files/mupen64plus-bundle-src-2.0.tar.gz'
  homepage 'http://code.google.com/p/mupen64plus/'
  sha1 '078a518e1b162bd88993e1815967fdafe61d9e28'

  option 'disable-osd', 'Disables the On Screen Display'
  option 'enable-new-dynarec', 'Replace dynamic recompiler with Ari64\'s experimental dynarec'
  option 'with-src', 'Build with libsamplerate'
  option 'with-speex', 'Build with libspeexdsp'

  depends_on 'pkg-config' => :build
  depends_on :libpng
  depends_on 'sdl'
  depends_on :freetype unless build.include? 'disable-osd'
  depends_on 'libsamplerate' if build.with? 'src'
  depends_on 'speex' => :optional

  def install
    commonArgs = ["install", "PREFIX=#{prefix}", "INSTALL_STRIP_FLAG=-S"]

    cd "source/mupen64plus-core/projects/unix" do
      args = commonArgs.dup
      args << "OSD=0" if build.include? 'disable-osd'
      args << "NEW_DYNAREC=1" if build.include? 'enable-new-dynarec'
      system "make", *args
    end

    cd "source/mupen64plus-audio-sdl/projects/unix" do
      args = commonArgs.dup
      args << "NO_SRC=1" if build.without? 'src'
      args << "NO_SPEEX=1" if build.without? 'speex'
      system "make", *args
    end

    cd "source/mupen64plus-input-sdl/projects/unix" do
      system "make", *commonArgs
    end

    cd "source/mupen64plus-rsp-hle/projects/unix" do
      system "make", *commonArgs
    end

    cd "source/mupen64plus-video-rice/projects/unix" do
      system "make", *commonArgs
    end

    cd "source/mupen64plus-ui-console/projects/unix" do
      system "make", *commonArgs
    end
  end
end
