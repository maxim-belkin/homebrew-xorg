class Libxcursor < Formula
  desc "X.Org Libraries: libXcursor"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXcursor-1.2.0.tar.bz2"
  sha256 "3ad3e9f8251094af6fe8cb4afcf63e28df504d46bfa5a5529db74a505d628782"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "614e45876b3fbdad20030acb41425026d0ec9a7686f429a60afd014b21e585d8" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxfixes"
  depends_on "linuxbrew/xorg/libxrender"

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
