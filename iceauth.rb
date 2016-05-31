# iceauth: Build a bottle for Linuxbrew
class Iceauth < Formula
  desc "X.Org Applications: iceauth"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/iceauth-1.0.7.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/iceauth-1.0.7.tar.bz2"
  sha256 "1216af2dee99b318fcf8bf9a259915273bcb37a7f1e7859af4f15d0ebf6f3f0a"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "xproto"     =>  :build
  depends_on "libice"

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
