class Libdrm < Formula
  desc "Library for accessing the direct rendering manager"
  homepage "https://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.100.tar.bz2"
  sha256 "c77cc828186c9ceec3e56ae202b43ee99eb932b4a87255038a80e8a1060d0a5d"

  livecheck do
    url "https://dri.freedesktop.org/libdrm/"
    regex(/href=.*?libdrm[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 "3bdefcc3770ecdede8364dffb38a5d64f1f3dbb0c862d5a5ec08208b3609d8f6" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

  depends_on "cairo" => :build if build.with? "test"
  depends_on "cunit" => :build if build.with? "test"
  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build
  depends_on "libxslt" => :build
  depends_on "pkg-config" => :build
  depends_on "valgrind" => [:build, :optional]
  depends_on "linuxbrew/xorg/libpciaccess"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-udev
      --enable-cairo-tests
      --enable-manpages
      --enable-valgrind=#{build.with?("valgrind") ? "yes" : "no"}
    ]

    # ensure we can find the docbook XML tags
    ENV["XML_CATALOG_FILES"] = etc/"xml/catalog"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
