class Xrandr < Formula
  desc "X.Org Applications: xrandr"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrandr-1.5.2.tar.xz"
  sha256 "c8bee4790d9058bacc4b6246456c58021db58a87ddda1a9d0139bf5f18f1f240"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9f6182c72da214ac032c65c8180921d86eab4612ced8363c2d5d01783404dd86"
  end

  option "without-xkeystone", "Delete (broken) xkeystone script"

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxrandr"
  depends_on "libxrender"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
    rm bin/"xkeystone" if build.without?("xkeystone")
  end
end
