class FontMiscMeltho < Formula
  desc "X.Org Fonts: font misc meltho"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  sha256 "3721323f13855cf7ca609115a1f7b182491e9b2b9c6e01eb1a2c7f8edd480791"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "01c561a754cda92bb144119c6e4d872266283fc8c7d65de372817fa6ab59ccda"
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
