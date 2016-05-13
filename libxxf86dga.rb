# libxxf86dga: Build a bottle for Linuxbrew
class Libxxf86dga < Formula
  desc "X.Org Libraries: libXxf86dga"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXxf86dga-1.1.4.tar.bz2"
  sha256 "8eecd4b6c1df9a3704c04733c2f4fa93ef469b55028af5510b25818e2456c77e"
  # tag "linuxbrew"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" =>  :build

  depends_on "libx11"
  depends_on "libxext"
  depends_on "xproto"     =>  :build
  depends_on "xextproto"  =>  :build
  depends_on "xf86dgaproto" => :build

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
