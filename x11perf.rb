# x11perf: Build a bottle for Linuxbrew
class X11perf < Formula
  desc "X.Org Applications: x11perf"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/x11perf-1.6.0.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/x11perf-1.6.0.tar.bz2"
  sha256 "e87098dec1947572d70c62697a7b70bde1ab5668237d4660080eade6bc096751"
  # tag "linuxbrew"


  depends_on "pkg-config" =>  :build
  depends_on "libx11"
  depends_on "libxmu"
  depends_on "xproto" => :build
  depends_on "libxrender" # crucial
  depends_on "libxft" # not crucial

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
