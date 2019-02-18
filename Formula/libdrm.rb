class Libdrm < Formula
  desc "Library for accessing the direct rendering manager"
  homepage "https://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.97.tar.bz2"
  sha256 "77d0ccda3e10d6593398edb70b1566bfe1a23a39bd3da98ace2147692eadd123"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "02c75401bd4d7051a64b4b8a2fd557a6740e8f4b8e32bb8e8679f845590fdb70" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

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
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    # ensure we can find the docbook XML tags
    ENV["XML_CATALOG_FILES"] = etc/"xml/catalog"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
