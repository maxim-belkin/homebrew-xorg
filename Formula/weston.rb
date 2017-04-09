class Weston < Formula
  desc "Reference implementation of a Wayland compositor"
  homepage "https://wayland.freedesktop.org"
  url "https://wayland.freedesktop.org/releases/weston-6.0.91.tar.xz"
  sha256 "b13810b59ffb04cabbe513766b88df24e95982745d200dd530368f973f43f56a"

  head do
    url "https://gitlab.freedesktop.org/wayland/weston"
  end

  depends_on "pkg-config" => :build
  depends_on "meson-internal" => :build
  depends_on "ninja" => :build
  depends_on "libxkbcommon"
  depends_on "linuxbrew/xorg/wayland"
  depends_on "linuxbrew/xorg/libdrm"
  depends_on "linuxbrew/xorg/libevdev"

  def install
    mkdir "build" do
      system "meson", "--prefix=#{prefix}"
      system "ninja"
      system "ninja", "install"
    end
  end
end
