class Libpciaccess < Formula
  desc "X.Org Libraries: libpciaccess"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/pub/individual/lib/libpciaccess-0.16.tar.bz2"
  sha256 "214c9d0d884fdd7375ec8da8dcb91a8d3169f263294c9a90c575bf1938b9f489"
  revision 1
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
  end

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

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
