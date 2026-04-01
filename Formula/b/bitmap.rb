class Bitmap < Formula
  desc "X.Org Applications: bitmap"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/bitmap-1.1.2.tar.xz"
  sha256 "5c6d2637244c575a9cc65a6b1ee15ced480ef0184821aceeab29650daf323c12"
  license "MIT"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xorgproto" => :build
  depends_on "libxaw"
  depends_on "libxmu"
  depends_on "libxt"
  depends_on "xbitmaps"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"

    # On macOS (case-insensitive filesystem), bitmap's Stipple conflicts with
    # xbitmaps' stipple; they are distinct files on Linux (case-sensitive).
    on_macos do
      rm_f include/"X11/bitmaps/Stipple"
    end
  end

  test do
    assert_predicate bin/"bitmap", :executable?
  end
end
