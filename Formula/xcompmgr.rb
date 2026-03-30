class Xcompmgr < Formula
  desc "X compositing manager"
  homepage "https://www.x.org/"
  url "https://www.x.org/pub/individual/app/xcompmgr-1.1.10.tar.xz"
  sha256 "7824f709c4f22432eaea7542ec93384e5dd48f6fcb85c12ff82d721423b0b98f"
  license "MIT"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxcomposite"
  depends_on "libxdamage"
  depends_on "libxext"
  depends_on "libxfixes"
  depends_on "libxrender"

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
    assert_predicate bin/"xcompmgr", :executable?
  end
end
