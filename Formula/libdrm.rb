class Libdrm < Formula
  desc "Library for accessing the direct rendering manager"
  homepage "https://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.99.tar.bz2"
  sha256 "4dbf539c7ed25dbb2055090b77ab87508fc46be39a9379d15fed4b5517e1da5e"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "c82794fc249a45b9f029a9ecd13b012edc2bfd3dc03fbb8455a8661efb09cf82" => :x86_64_linux
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
