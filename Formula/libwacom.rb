class Libwacom < Formula
  desc "Library to identify wacom tablets and their model-specific features"
  homepage "https://github.com/linuxwacom/libwacom"
  url "https://github.com/linuxwacom/libwacom/releases/download/libwacom-2.18.0/libwacom-2.18.0.tar.xz"
  sha256 "7dbb9ab37df9df47ae2fdbb644916c986728291749bcd5ad8bcaa26f1e15f002"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
    regex(/^libwacom[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "libgudev"
  depends_on "maxim-belkin/xorg/libevdev"

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
