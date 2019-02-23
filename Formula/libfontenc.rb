class Libfontenc < Formula
  desc "X.Org Libraries: libfontenc"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libfontenc-1.1.4.tar.bz2"
  sha256 "2cfcce810ddd48f2e5dc658d28c1808e86dcf303eaff16728b9aa3dbc0092079"
  # tag "linuxbrew"

  bottle do
    sha256 "62966fcff8983e11ad73ba816c1df0837f4263b94be9ec184e8615047657f845" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "linuxbrew/xorg/font-util" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "zlib"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
