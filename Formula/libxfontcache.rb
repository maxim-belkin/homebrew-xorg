class Libxfontcache < Formula
  desc "X.Org Libraries: libXfontCache"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXfontcache-1.0.5.tar.gz"
  sha256 "fdba75307a0983d2566554e0e9effa7079551f1b7b46e8de642d067998619659"
  revision 1

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "maxim-belkin/xorg/fontcacheproto"

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
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
