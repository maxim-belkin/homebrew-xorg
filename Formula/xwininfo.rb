class Xwininfo < Formula
  desc "X.Org Applications: xwininfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwininfo-1.1.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xwininfo-1.1.4.tar.bz2"
  sha256 "839498aa46b496492a5c65cd42cd2e86e0da88149b0672e90cb91648f8cd5b01"
  # tag "linuxbrew"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/xcb-util-wm"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xcb-icccm
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
