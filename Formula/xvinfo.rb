class Xvinfo < Formula
  desc "X.Org Applications: xvinfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xvinfo-1.1.4.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xvinfo-1.1.4.tar.bz2"
  sha256 "0353220d6606077ba42363db65f50410759f9815352f77adc799e2adfa76e73f"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxv"

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
