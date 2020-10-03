class Libxxf86misc < Formula
  desc "X.Org Libraries: libXxf86misc"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/lib/libXxf86misc-1.0.4.tar.gz"
  sha256 "63a68b2fafd03236f9b0135de21976e9194d6d811ca2fd774c13a6b4be576676"
  revision 1
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
  end

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "xorgproto"

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
