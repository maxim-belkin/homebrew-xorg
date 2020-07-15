class Xkbcomp < Formula
  desc "X.Org Applications: xkbcomp"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbcomp-1.4.3.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xkbcomp-1.4.3.tar.bz2"
  sha256 "06242c169fc11caf601cac46d781d467748c6a330e15b36dce46520b8ac8d435"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "3956c51a54082f8be79ddce4eeddcef9b9e98f15a75ad880fb767ad0a6dbf68f" => :x86_64_linux
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
      --with-xkb-config-root=#{Formula["libx11"].opt_share}/X11/xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
