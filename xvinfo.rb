# xvinfo: Build a bottle for Linuxbrew
class Xvinfo < Formula
  desc "X.Org Applications: xvinfo"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xvinfo-1.1.3.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xvinfo-1.1.3.tar.bz2"
  sha256 "9fba8b68daf53863e66d5004fa9c703fcecf69db4d151ea2d3d885d621e6e5eb"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "xproto" => :build
  depends_on "libx11"
  depends_on "libxv"

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
