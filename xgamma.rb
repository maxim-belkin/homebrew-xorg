# xgamma: Build a bottle for Linuxbrew
class Xgamma < Formula
  desc "X.Org Applications: xgamma"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xgamma-1.0.6.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xgamma-1.0.6.tar.bz2"
  sha256 "0ef1c35b5c18b1b22317f455c8df13c0a471a8efad63c89c98ae3ce8c2b222d3"
  # tag "linuxbrew"


  depends_on "pkg-config" =>  :build
  depends_on "libx11"
  depends_on "libxxf86vm"
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
