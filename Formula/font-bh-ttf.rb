class FontBhTtf < Formula
  desc "X.Org Fonts: font bh ttf"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-bh-ttf-1.0.4.tar.xz"
  sha256 "85a5f90d00c48c2b06fd125ea8adbc8b8ee97429e3075081c8710926efec3a56"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ccac8fb0ed810ed9e0c4a55a5060be0996f2bd7ea0df24f1fa93d100ad6ada1e"
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

  test do
    assert_predicate share/"fonts/X11", :directory?
  end
end
