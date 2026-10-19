class Libwacom < Formula
  desc "Library to identify wacom tablets and their model-specific features"
  homepage "https://github.com/linuxwacom/libwacom"
  url "https://github.com/linuxwacom/libwacom/releases/download/libwacom-2.20.0/libwacom-2.20.0.tar.xz"
  sha256 "370b45b5e05a91960df0aeb9c9481ae05846aab92ab2d4ec66945a0da4216888"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
    regex(/^libwacom[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 x86_64_linux: "e7b94d9373fae7c7f6bd8ac14e13089dd05312a6c67b8e2b4c6882229e0a4eef"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "libevdev"
  depends_on "libgudev"

  def install
    args = std_meson_args + %w[
      -Ddocumentation=disabled
      -Dtests=disabled
    ]

    system "meson", "setup", "build", *args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_path_exists lib/"libwacom.so"
  end
end
