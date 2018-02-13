class Xkbcomp < Formula
  desc "X.Org Applications: xkbcomp"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbcomp-1.4.0.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xkbcomp-1.4.0.tar.bz2"
  sha256 "bc69c8748c03c5ad9afdc8dff9db11994dd871b614c65f8940516da6bf61ce6b"
  # tag "linuxbrew"

  bottle do
    sha256 "06e98fce274363e5105d4ebedd1f8a38e8c82ed12591e67108fa5b9a0424e74d" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxkbfile"

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
