class Libxfontcache < Formula
  desc "X.Org Libraries: libXfontCache"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXfontcache-1.0.5.tar.gz"
  sha256 "fdba75307a0983d2566554e0e9effa7079551f1b7b46e8de642d067998619659"
  revision 1

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/libxfontcache-1.0.5_1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "631c84fccc8734f5e1a2cedc5fe97e5291c13db61ff58b6668915e515de8478a"
  end

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
