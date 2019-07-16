class Libxcomposite < Formula
  desc "X.Org Libraries: libXcomposite"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXcomposite-0.4.5.tar.bz2"
  sha256 "b3218a2c15bab8035d16810df5b8251ffc7132ff3aa70651a1fba0bfe9634e8f"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "dee697e5ac68ee9cf255ddadb7ab3d847211ace22493e22442bea3d997d24659" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libxfixes"
  depends_on "linuxbrew/xorg/xorgproto"

  # Configure script says that libXcomposite depends on xmlto
  # which  is used to regenerate documentation.
  # But xmlto is never used (according to the log)
  # so we do not add this dependency.

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
