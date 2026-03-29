class FontCronyxCyrillic < Formula
  desc "X.Org Fonts: font cronyx cyrillic"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-cronyx-cyrillic-1.0.4.tar.xz"
  sha256 "dc0781ce0dcbffdbf6aae1a00173a13403f92b0de925bca5a9e117e4e2d6b789"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4b164bfb69bbcecde1751dad97aa836f67c7bfdb5c819817fb39b9a3b47173b6"
  end

  keg_only "part of Xorg-fonts package"

  depends_on "bdftopcf" => :build
  depends_on "bzip2" => :build
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
      --with-compression=bzip2
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
