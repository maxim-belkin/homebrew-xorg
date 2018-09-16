class Libxcb < Formula
  desc "Interface to the X Window System protocol and replacement for Xlib"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://xcb.freedesktop.org/dist/libxcb-1.13.tar.bz2"
  sha256 "188c8752193c50ff2dbe89db4554c63df2e26a2e47b0fa415a70918b5b851daa"
  # tag "linuxbrew"

  bottle do
    sha256 "d39e8d02208a650f4760ab198316f8e900bcbde2f52ce4e7e3c5cb6950afc17d" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-devel-docs", "Build developer documentation"

  depends_on "pkg-config" => :build
  depends_on "python" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" => :build # xcb.pc references pthread-stubs
  depends_on "linuxbrew/xorg/xcb-proto" => :build
  depends_on "linuxbrew/xorg/xproto" => :build # no linkage
  depends_on "linuxbrew/xorg/libxau"
  depends_on "linuxbrew/xorg/libxdmcp" => :recommended

  if build.with? "devel-docs"
    depends_on "doxygen" => :build
    depends_on "graphviz" => :build
  end

  if build.with? "test"
    depends_on "check" => :build
    depends_on "libxslt" => [:build, :recommended]
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
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
