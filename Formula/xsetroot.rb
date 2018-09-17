class Xsetroot < Formula
  desc "X.Org Applications: xsetroot"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xsetroot-1.1.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xsetroot-1.1.2.tar.bz2"
  sha256 "10c442ba23591fb5470cea477a0aa5f679371f4f879c8387a1d9d05637ae417c"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "79a6e85d103713f0b4c5d3d4cd8030a97a4bbd0a285c6d1a648ac99147ea30b2" => :x86_64_linux
  end

  # xmuu x11 xbitmaps xcursor xproto
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xbitmaps" => :build
  depends_on "linuxbrew/xorg/libxmu"
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
