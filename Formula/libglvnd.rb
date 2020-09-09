class Libglvnd < Formula
  desc "GL Vendor-Neutral Dispatch library"
  homepage "https://github.com/NVIDIA/libglvnd"
  url "https://github.com/NVIDIA/libglvnd/archive/v1.3.0.tar.gz"
  sha256 "fabf98e72e172a1402617f5daade4dd79c752a77ab1688e0c1a0ffc49605040f"
  revision 1
  head "https://gitlab.freedesktop.org/glvnd/libglvnd.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0a23a0224a74e409d5ed4ed556a26a20f28db30afef4b8340feaa957a91e2ec3" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/libpthread-stubs" => :build
  depends_on "linuxbrew/xorg/libxext" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"

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
