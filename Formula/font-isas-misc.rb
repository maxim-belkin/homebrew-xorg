class FontIsasMisc < Formula
  desc "X.Org Fonts: font isas misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-isas-misc-1.0.4.tar.xz"
  sha256 "47e595bbe6da444b9f6fcaa26539abc7ba1989e23afa6cdc49e22e484cc438fc"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2369a0d9b3cbac3d749d976dd7173d11368bba852cb51d079ddce08a5cb891c1"
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
