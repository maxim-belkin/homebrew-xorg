class Xsetroot < Formula
  desc "X.Org Applications: xsetroot"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xsetroot-1.1.1.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xsetroot-1.1.1.tar.bz2"
  sha256 "ba215daaa78c415fce11b9e58c365d03bb602eaa5ea916578d76861a468cc3d9"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "79a6e85d103713f0b4c5d3d4cd8030a97a4bbd0a285c6d1a648ac99147ea30b2" => :x86_64_linux
  end

  # xmuu x11 xbitmaps xcursor xproto
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxmu"
  depends_on "linuxbrew/xorg/xbitmaps"
  depends_on "linuxbrew/xorg/libxcursor"

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
  end
end
