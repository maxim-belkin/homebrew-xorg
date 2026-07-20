class Libwacom < Formula
  desc "Library to identify wacom tablets and their model-specific features"
  homepage "https://github.com/linuxwacom/libwacom"
  url "https://github.com/linuxwacom/libwacom/releases/download/libwacom-2.19.1/libwacom-2.19.1.tar.xz"
  sha256 "a1e5b1e7ef60fa70ed05b55d888d980ec7e86bd15594857f3c48c529b661bf32"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
    regex(/^libwacom[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 x86_64_linux: "78f16c5d1f9d5dffa5cf54abbd40999143502154531439c687e7fa898c8505f9"
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
