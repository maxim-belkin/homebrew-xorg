class Xclock < Formula
  desc "X.Org Applications: xclock"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xclock-1.1.1.tar.xz"
  sha256 "df7ceabf8f07044a2fde4924d794554996811640a45de40cb12c2cf1f90f742c"
  license "MIT"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxaw"
  depends_on "libxft"
  depends_on "libxkbfile"
  depends_on "libxmu"
  depends_on "libxrender"
  depends_on "libxt"

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
  end

  test do
    assert_predicate bin/"xclock", :executable?
  end
end
