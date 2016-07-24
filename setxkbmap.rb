# setxkbmap: Build a bottle for Linuxbrew
class Setxkbmap < Formula
  desc "X.Org Applications: setxkbmap"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/setxkbmap-1.3.1.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/setxkbmap-1.3.1.tar.bz2"
  sha256 "a9ddb3963f263ba13f0ea105d8c45a531832140530217cc559587bb94f02d3e1"
  # tag "linuxbrew"


  depends_on "pkg-config" =>  :build
  depends_on "libxkbfile"
  depends_on "libx11"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb-config-root=#{Formula["libx11"].share}/X11/xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
