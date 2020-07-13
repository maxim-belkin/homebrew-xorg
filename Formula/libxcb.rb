class Libxcb < Formula
  desc "Interface to the X Window System protocol and replacement for Xlib"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://xcb.freedesktop.org/dist/libxcb-1.13.1.tar.bz2"
  sha256 "a89fb7af7a11f43d2ce84a844a4b38df688c092bf4b67683aef179cdf2a647c4"
  revision 1
  # tag "linuxbrew"

  livecheck do
    url "https://ftp.x.org/archive/individual/lib/"
    regex(/libxcb-([0-9.]+)\.tar.gz/)
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "71e21416bda37d0b5468451eb73b65abf3edce3ced56f12c4da45412ce2c5f36" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-devel-docs", "Build developer documentation"

  depends_on "linuxbrew/xorg/xcb-proto" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.8" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" # xcb.pc references pthread-stubs
  depends_on "linuxbrew/xorg/libxau"
  depends_on "linuxbrew/xorg/libxdmcp"

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
