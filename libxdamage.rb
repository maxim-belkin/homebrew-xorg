# libxdamage: Build a bottle for Linuxbrew
class Libxdamage < Formula
  desc "X.Org Libraries: libXdamage"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXdamage-1.1.4.tar.bz2"
  sha256 "7c3fe7c657e83547f4822bfde30a90d84524efb56365448768409b77f05355ad"
  # tag "linuxbrew"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" =>  :build
  depends_on "damageproto" => :build
  depends_on "libxfixes"
  depends_on "fixesproto" =>  :build
  depends_on "xextproto"  =>  :build
  depends_on "libx11"

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
