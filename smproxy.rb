# smproxy: Build a bottle for Linuxbrew
class Smproxy < Formula
  desc "X.Org Applications: smproxy"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/smproxy-1.0.6.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/smproxy-1.0.6.tar.bz2"
  sha256 "6cf19155a2752237f36dbf8bc4184465ea190d2652f887faccb4e2a6ebf77266"
  # tag "linuxbrew"


  depends_on "pkg-config" =>  :build
  depends_on "libsm"
  depends_on "libice"
  depends_on "libxt"
  depends_on "libxmu"
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
