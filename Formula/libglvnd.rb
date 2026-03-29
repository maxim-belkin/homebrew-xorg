class Libglvnd < Formula
  desc "GL Vendor-Neutral Dispatch library"
  homepage "https://github.com/NVIDIA/libglvnd"
  url "https://github.com/NVIDIA/libglvnd/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "fabf98e72e172a1402617f5daade4dd79c752a77ab1688e0c1a0ffc49605040f"
  license "MIT"
  revision 2
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

    system "meson", "setup", "build", *args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_path_exists lib/"libGLdispatch.so"
  end
end
