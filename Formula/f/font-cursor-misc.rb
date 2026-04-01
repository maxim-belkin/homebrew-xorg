class FontCursorMisc < Formula
  desc "X.Org Fonts: font cursor misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-cursor-misc-1.0.4.tar.xz"
  sha256 "25d9c9595013cb8ca08420509993a6434c917e53ca1fec3f63acd45a19d4f982"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ffe7b0fee351cd193f88e428bb85f0e1b3e0079b2eb4a60854a03e5628b6c221"
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
