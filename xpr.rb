# xpr: Build a bottle for Linuxbrew (a third time)
class Xpr < Formula
  desc "X.Org Applications: xpr"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xpr-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xpr-1.0.4.tar.bz2"
  sha256 "fed98df31eb93d3dca4688cb535aabad06be572e70ace3b1685679c18dd86cb5"
  # tag "linuxbrew"


  depends_on "pkg-config" =>  :build
  depends_on "xproto" => :build
  depends_on "libx11"
  depends_on "libxmu"

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
