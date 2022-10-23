class FontXfree86Type1 < Formula
  desc "X.Org Fonts: font xfree86 type1"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-xfree86-type1-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-xfree86-type1-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-xfree86-type1-1.0.4.tar.bz2"
  sha256 "caebf42aec7be7f3bd40e0f232d6f34881b853dc84acfcdf7458358701fbe34a"
  revision 2

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/font-xfree86-type1-1.0.4_2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "daba648256c7d627900eaaa337b1a8344bfcdac00ec5271d97ee30ee43b74751"
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
