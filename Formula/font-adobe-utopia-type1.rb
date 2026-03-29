class FontAdobeUtopiaType1 < Formula
  desc "X.Org Fonts: font adobe utopia type1"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-adobe-utopia-type1-1.0.5.tar.xz"
  sha256 "4cb280bc47693b07c5e00fd0e5ad5721aabebc0548c3f06774e5cc3cbcf75697"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 2
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ee4f1d3395926f20de4ff1947c531ec8c8e5e69bda80b3c22a4a4538fabafa7a"
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
