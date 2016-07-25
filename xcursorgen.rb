# xcursorgen: Build a bottle for Linuxbrew
class Xcursorgen < Formula
  desc "X.Org Applications: xcursorgen"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xcursorgen-1.0.6.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xcursorgen-1.0.6.tar.bz2"
  sha256 "31c8910f54eb175a8a74a60e7662697467e21a8bf948220a6048a93924b3f66c"
  # tag "linuxbrew"


  depends_on "pkg-config" =>  :build
  depends_on "libx11"
  depends_on "libxcursor"
  depends_on "libpng"

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
