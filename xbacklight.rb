# xbacklight: Build a bottle for Linuxbrew
class Xbacklight < Formula
  desc "X.Org Applications: xbacklight"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xbacklight-1.2.1.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xbacklight-1.2.1.tar.bz2"
  sha256 "17f6cf51a35eaa918abec36b7871d28b712c169312e22a0eaf1ffe8d6468362b"
  # tag "linuxbrew"

  # xcb-randr >= 1.2 xcb-atom xcb-aux xcb
  depends_on "pkg-config" =>  :build
  depends_on "libxcb"
  depends_on "xcb-util"
  depends_on "xcb-util-image"

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
