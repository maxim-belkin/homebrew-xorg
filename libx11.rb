class Libx11 < Formula
  desc "X.Org Libraries: libX11"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libX11-1.6.5.tar.bz2"
  sha256 "4d3890db2ba225ba8c55ca63c6409c1ebb078a2806de59fb16342768ae63435d"
  # tag "linuxbrew"

  bottle do
    sha256 "83ef79752cdd15f34eabfe1c38b82e78d3fe75b77f2ecd22a26ea18af14753d5" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-specs", "Build specifications"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xextproto" => :build
  depends_on "linuxbrew/xorg/xtrans" => :build
  depends_on "linuxbrew/xorg/libxcb"
  depends_on "linuxbrew/xorg/kbproto" => :build
  depends_on "linuxbrew/xorg/inputproto" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("specs")
    depends_on "xmlto" => :build
    depends_on "fop" => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "perl" => [:build, :optional]
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => [:build, :recommended]
  end

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
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
