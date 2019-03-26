class Libxcb < Formula
  desc "Interface to the X Window System protocol and replacement for Xlib"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://xcb.freedesktop.org/dist/libxcb-1.13.1.tar.bz2"
  sha256 "a89fb7af7a11f43d2ce84a844a4b38df688c092bf4b67683aef179cdf2a647c4"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-devel-docs", "Build developer documentation"

  depends_on "linuxbrew/xorg/xcb-proto" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" # xcb.pc references pthread-stubs
  depends_on "linuxbrew/xorg/libxau"
  depends_on "linuxbrew/xorg/libxdmcp"

  if build.with? "devel-docs"
    depends_on "doxygen" => :build
    depends_on "graphviz" => :build
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-dri3
      --enable-ge
      --enable-xevie
      --enable-xprint
      --enable-selinux
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
      --enable-devel-docs=#{build.with?("devel-docs") ? "yes" : "no"}
      --with-doxygen=#{build.with?("devel-docs") ? "yes" : "no"}
    ]

    ENV["DOT"] = Formula["graphviz"].opt_bin if build.with? "devel-docs"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
