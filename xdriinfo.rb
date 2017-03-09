class Xdriinfo < Formula
  desc "X.Org Applications: xdriinfo"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xdriinfo-1.0.5.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xdriinfo-1.0.5.tar.bz2"
  sha256 "4cba3766ef89557422062287248adeb933999071bad6f3ef9c0a478a3c680119"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/glproto"
  depends_on "linuxbrew/xorg/mesa"

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
