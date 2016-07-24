# xrefresh: Build a bottle for Linuxbrew
class Xrefresh < Formula
  desc "X.Org Applications: xrefresh"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xrefresh-1.0.5.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xrefresh-1.0.5.tar.bz2"
  sha256 "3213671b0a8a9d1e8d1d5d9e3fd86842c894dd9acc1be2560eda50bc1fb791d6"
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
