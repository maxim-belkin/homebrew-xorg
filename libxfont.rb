class Libxfont < Formula
  desc "X.Org Libraries: libXfont"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXfont-1.5.2.tar.bz2"
  sha256 "02945ea68da447102f3e6c2b896c1d2061fd115de99404facc2aca3ad7010d71"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "8b71f987f0e359072c3bfdafc05a684bf1ca6325e7868b36701813ab3e643dec" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-devel-docs", "Build developer documentation"

  option "with-brewed-zlib", "Use brewed zlib"
  option "with-brewed-bzip2", "Use libbz2 to support bzip2 compressed bitmap fonts"

  # Required dependencies
  depends_on "pkg-config" => :build
  depends_on "xproto"
  depends_on "xtrans" => :build
  depends_on "fontsproto"
  depends_on "libfontenc"
  depends_on "freetype"

  # Optional dependencies
  depends_on "bzip2" if build.with?("brewed-bzip2")
  depends_on "zlib"  if build.with?("brewed-zlib")

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("devel-docs")
    depends_on "xmlto" => :build
    depends_on "fop" => [:build, :recommended]
    depends_on "xorg-sgml-doctools" => [:build, :recommended]
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
    args << "--enable-devel-docs=#{build.with?("devel-docs") ? "yes" : "no"}"
    args << "--with-freetype-config=#{Formula["freetype"].bin}/freetype-config"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
