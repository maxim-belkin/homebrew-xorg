class FontIbmType1 < Formula
  desc "X.Org Fonts: font ibm type1"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-ibm-type1-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-ibm-type1-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-ibm-type1-1.0.3.tar.bz2"
  sha256 "fddb28d3db5a07f4b4ca15388488a9680a10e1367a18f358f903b2a608a5d2df"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "62a67aadbc3a616cae67a59101408be7637512fb1ed0961a61f29c4f68ebaf45"
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
