class Libdmx < Formula
  desc "X.Org Libraries: libdmx"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libdmx-1.1.3.tar.bz2"
  sha256 "c97da36d2e56a2d7b6e4f896241785acc95e97eb9557465fd66ba2a155a7b201"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "ecaf5224f64f66117ad4bbcd6a380086468eb642b807ea93f0573c2d1e8d5e5e" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/xextproto" => :build
  depends_on "linuxbrew/xorg/dmxproto" => :build

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
