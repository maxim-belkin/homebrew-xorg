class Xbacklight < Formula
  desc "X.Org Applications: xbacklight"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xbacklight-1.2.3.tar.bz2"
  sha256 "3a27f324777ae99fee476cfb2f064576fb8cba4eb77f97cda37adda1c1d39ade"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "libxcb"
  depends_on "xcb-util"

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
