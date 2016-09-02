# xev: Build a bottle for Linuxbrew
class Xev < Formula
  desc "X.Org Applications: xev"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xev-1.2.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xev-1.2.2.tar.bz2"
  sha256 "d94ae62a6c1af56c2961d71f5782076ac4116f0fa4e401420ac7e0db33dc314f"
  # tag "linuxbrew"


  depends_on "pkg-config" =>  :build
  depends_on "libxrandr"
  depends_on "libx11"
  depends_on "xproto" => :build

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
