class Libdrm < Formula
  desc "Library for accessing the direct rendering manager"
  homepage "https://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.94.tar.bz2"
  sha256 "b73c59b0a3760502c428ba81de49cd4807657d26be5e697eba3a87dd021d16be"

  bottle do
    sha256 "6993d092717699c084bb6723576475183c675f9f19aa9c4e051ee19bfa892cf5" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libpciaccess"
  depends_on "cunit" => :build if build.with? "test"
  depends_on "cairo" => :build if build.with? "test"
  depends_on "valgrind" => [:build, :optional]

  depends_on "libxslt" => :build
  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build

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
