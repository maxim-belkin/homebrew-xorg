class Libxdamage < Formula
  desc "X.Org Libraries: libXdamage"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXdamage-1.1.4.tar.bz2"
  sha256 "7c3fe7c657e83547f4822bfde30a90d84524efb56365448768409b77f05355ad"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "399e510a78f416268e583f948595884cf458db56098b779fb94f823240b65a14" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/damageproto" => :build
  depends_on "linuxbrew/xorg/libxfixes"
  depends_on "linuxbrew/xorg/fixesproto" => :build
  depends_on "linuxbrew/xorg/xextproto"  => :build
  depends_on "linuxbrew/xorg/libx11"

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
