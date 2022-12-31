class Libglvnd < Formula
  desc "GL Vendor-Neutral Dispatch library"
  homepage "https://github.com/NVIDIA/libglvnd"
  url "https://github.com/NVIDIA/libglvnd/archive/v1.6.0.tar.gz"
  sha256 "e31dd71441604cf7467397e740af8070caa84133b5ed71241d3d5ca84c950baf"
  head "https://gitlab.freedesktop.org/glvnd/libglvnd.git"

  depends_on "libpthread-stubs" => :build
  depends_on "libxext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"

  def install
    args = %W[
      -Dprefix=#{prefix}
      -Dsysconfdir=#{etc}
      -Dlocalstatedir=#{var}
      -Dasm=enabled
      -Dx11=enabled
      -Dglx=enabled
      -Dtls=enabled
    ]

    mkdir "build" do
      system "meson", *args
      system "ninja"
      system "ninja", "install"
    end
  end
end
