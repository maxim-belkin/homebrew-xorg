class Xkbevd < Formula
  desc "X.Org Applications: xkbevd"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbevd-1.1.4.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xkbevd-1.1.4.tar.bz2"
  sha256 "2430a2e5302a4cb4a5530c1df8cb3721a149bbf8eb377a2898921a145197f96a"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "libxkbfile"

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
