class FontMiscEthiopic < Formula
  desc "X.Org Fonts: font misc ethiopic"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-misc-ethiopic-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-misc-ethiopic-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-misc-ethiopic-1.0.4.tar.bz2"
  sha256 "698c0f6ddf9ca482250bdafa08293893148393bb9cb23e0a9ca313c6dbfc4ae0"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c6853772aa434cf8d8b333e6e2b297dbd670723636577ccb46aaddb3910103cf"
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
