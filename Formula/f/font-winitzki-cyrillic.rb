class FontWinitzkiCyrillic < Formula
  desc "X.Org Fonts: font winitzki cyrillic"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-winitzki-cyrillic-1.0.4.tar.xz"
  sha256 "3b6d82122dc14776e3afcd877833a7834e1f900c53fc1c7bb2d67c781cfa97a8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "53a269805ba5b58c86909cb9da12346ba371ebaf61190b645502928ebd33ed9a"
  end

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
