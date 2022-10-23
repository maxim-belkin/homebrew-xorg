class XcursorThemes < Formula
  desc "X.Org: redglass and whiteglass animated cursor themes"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/archive/individual/data/xcursor-themes-1.0.6.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/data/xcursor-themes-1.0.6.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/data/xcursor-themes-1.0.6.tar.bz2"
  sha256 "ee1ec574741293abcf66ac14ce7e74add7ac6be7deb8b38179ef010d22354999"
  revision 1

  depends_on "maxim-belkin/xorg/xcursorgen" => :build
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-cursordir=#{pkgshare}/icons
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
