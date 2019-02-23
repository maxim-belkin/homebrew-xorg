class Libx11 < Formula
  desc "X.Org Libraries: libX11"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libX11-1.6.7.tar.bz2"
  sha256 "910e9e30efba4ad3672ca277741c2728aebffa7bc526f04dcfa74df2e52a1348"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "f0f2a5a7d7c735d47dba9d0dbdc34c8aeebf6e9333fa9e6193bbcf66a2b4e7ab" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-specs", "Build specifications"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xtrans" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libxcb"
  depends_on "linuxbrew/xorg/xorgproto"

  if build.with? "specs"
    depends_on "xmlto" => :build
    depends_on "lynx" => :build
    depends_on "libxslt" => :build
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => :build
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-unix-transport
      --enable-tcp-transport
      --enable-ipv6
      --enable-local-transport
      --enable-loadable-i18n
      --enable-xthreads
      --enable-static=#{build.with?("static") ? "yes" : "no"}
      --enable-specs=#{build.with?("specs") ? "yes" : "no"}
    ]

    # ensure we can find the docbook XML tags
    ENV["XML_CATALOG_FILES"] = etc/"xml/catalog" if build.with? "specs"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
