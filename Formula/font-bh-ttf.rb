class FontBhTtf < Formula
  desc "X.Org Fonts: font bh ttf"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-bh-ttf-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-bh-ttf-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-bh-ttf-1.0.3.tar.bz2"
  sha256 "1b4bea63271b4db0726b5b52c97994c3313b6023510349226908090501abd25f"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c1217b5b4cf4167e8a605d51d3b9e1510e50783f4db15990ed09af57ccddde51"
  end

  keg_only "part of Xorg-fonts package"

  depends_on "bdftopcf" => :build
  depends_on "font-util" => :build
  depends_on "fontconfig" => :build
  depends_on "mkfontscale" => :build
  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
