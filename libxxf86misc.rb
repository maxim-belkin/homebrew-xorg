# libxxf86misc: Build a bottle for Linuxbrew
class Libxxf86misc < Formula
  desc "X.Org Libraries: libXxf86misc"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "https://www.x.org/archive//individual/lib/libXxf86misc-1.0.3.tar.gz"
  sha256 "358f692f793af00f6ef4c7a8566c1bcaeeea37e417337db3f519522cc1df3946"
  # tag "linuxbrew"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" =>  :build

  depends_on "xproto"     =>  :build
  depends_on "xextproto"  =>  :build
  depends_on "xf86miscproto" =>  :build
  depends_on "libx11"
  depends_on "libxext"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
