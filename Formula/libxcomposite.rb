class Libxcomposite < Formula
  desc "X.Org Libraries: libXcomposite"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXcomposite-0.4.5.tar.bz2"
  sha256 "b3218a2c15bab8035d16810df5b8251ffc7132ff3aa70651a1fba0bfe9634e8f"
  # tag "linuxbrew"

  livecheck do
    url "https://ftp.x.org/archive/individual/lib/"
    regex(/libXcomposite-([0-9.]+)\.tar.bz2/)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "5cf6cc0b18a15c3fdb80b0010a474d932ef8e4f25d537ce3f2cada9939a0f385" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

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
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
