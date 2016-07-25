# xprop: Build a bottle for Linuxbrew
class Xprop < Formula
  desc "X.Org Applications: xprop"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xprop-1.2.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xprop-1.2.2.tar.bz2"
  sha256 "9bee88b1025865ad121f72d32576dd3027af1446774aa8300cce3c261d869bc6"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "xproto" => :build
  depends_on "libx11"

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
