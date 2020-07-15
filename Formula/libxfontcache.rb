# libxfontcache: Build a bottle for Linux
class Libxfontcache < Formula
  desc "X.Org Libraries: libXfontCache"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXfontcache-1.0.5.tar.gz"
  sha256 "fdba75307a0983d2566554e0e9effa7079551f1b7b46e8de642d067998619659"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "3b8897ea5bd5244076f029fe03c6bd60795e18c032a3c5aa739d053ed63eddc4" => :x86_64_linux
  end

  # tag "linuxbrew"

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/fontcacheproto"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"

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
