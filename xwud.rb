# xwud: Build a bottle for Linuxbrew
class Xwud < Formula
  desc "X.Org Applications: xwud"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xwud-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xwud-1.0.4.tar.bz2"
  sha256 "d6b3a09ccfe750868e26bd2384900ab5ff0d434f7f40cd272a50eda8aaa1f8bd"
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
