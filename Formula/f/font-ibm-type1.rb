class FontIbmType1 < Formula
  desc "X.Org Fonts: font ibm type1"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-ibm-type1-1.0.4.tar.xz"
  sha256 "c4395e95ba46d40c4ad1737e91cac20c0ab75411329b60db5d99fed92b60ce7f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a2f4edf5f2e917678bd941c88c622092c7051bc8c3478a3ecb1d081e2c034ea7"
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
