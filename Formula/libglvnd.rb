class Libglvnd < Formula
  desc "GL Vendor-Neutral Dispatch library"
  homepage "https://github.com/NVIDIA/libglvnd"
  url "https://github.com/NVIDIA/libglvnd/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "073e7292788d4d3eeb45ea6c7bdcce9bfdb3b3eef8d7dbd47f2f30dce046ef98"
  license "MIT"
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
    args = std_meson_args + %w[
      -Dasm=enabled
      -Dx11=enabled
      -Dglx=enabled
      -Dtls=true
    ]

    system "meson", "setup", "build", *args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_path_exists lib/"libGLdispatch.so"
  end
end
