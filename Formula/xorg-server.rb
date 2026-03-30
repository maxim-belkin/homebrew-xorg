class XorgServer < Formula
  desc "X.Org X server"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/xorg-server.html
  url "https://www.x.org/pub/individual/xserver/xorg-server-21.1.21.tar.xz"
  sha256 "c0cbe5545b3f645bae6024b830d1d1154a956350683a4e52b2fff5b0fa1ab519"
  license "MIT"

  depends_on "font-util" => :build
  depends_on "libxkbfile" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xorgproto" => :build
  depends_on "xtrans" => :build
  depends_on "libdrm"
  depends_on "libepoxy"
  depends_on "libpciaccess"
  depends_on "libx11"
  depends_on "libxau"
  depends_on "libxcb"
  depends_on "libxcvt"
  depends_on "libxdmcp"
  depends_on "libxext"
  depends_on "libxfixes"
  depends_on "libxfont2"
  depends_on "libxshmfence"
  depends_on "mesa"
  depends_on "nettle"
  depends_on "pixman"
  depends_on "xauth"
  depends_on "xcb-util"
  depends_on "xcb-util-image"
  depends_on "xcb-util-keysyms"
  depends_on "xcb-util-renderutil"
  depends_on "xcb-util-wm"
  depends_on "xkbcomp"
  depends_on "xkeyboard-config"

  def install
    args = std_meson_args + %W[
      -Dxorg=true
      -Dxvfb=true
      -Dxephyr=false
      -Dxnest=false
      -Ddmx=false
      -Dxwayland=false
      -Dsuid_wrapper=false
      -Dsystemd_logind=false
      -Dudev=false
      -Ddtrace=false
      -Dxkb_dir=#{HOMEBREW_PREFIX}/share/X11/xkb
      -Dxkb_output_dir=#{var}/lib/xkb
      -Ddefault_font_path=#{HOMEBREW_PREFIX}/share/fonts/X11
    ]

    system "meson", "setup", "build", *args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_predicate bin/"Xvfb", :executable?
  end
end
