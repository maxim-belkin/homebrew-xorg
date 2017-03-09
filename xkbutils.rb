class Xkbutils < Formula
  desc "X.Org Applications: xkbutils"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xkbutils-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xkbutils-1.0.4.tar.bz2"
  sha256 "d2a18ab90275e8bca028773c44264d2266dab70853db4321bdbc18da75148130"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libxaw"
  depends_on "linuxbrew/xorg/libxt"
  depends_on "linuxbrew/xorg/libx11"

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
