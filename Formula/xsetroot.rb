class Xsetroot < Formula
  desc "X.Org Applications: xsetroot"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xsetroot-1.1.2.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xsetroot-1.1.2.tar.bz2"
  sha256 "10c442ba23591fb5470cea477a0aa5f679371f4f879c8387a1d9d05637ae417c"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "c3c945a829a7df41efab464fe6dabe72432fc0ca240fae141af6ba7802867297" => :x86_64_linux
  end

  # xmuu x11 xbitmaps xcursor xorgproto
  depends_on "linuxbrew/xorg/xbitmaps" => :build
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libxcursor"
  depends_on "libxmu"

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
