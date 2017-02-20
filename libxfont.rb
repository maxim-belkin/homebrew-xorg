class Libxfont < Formula
  desc "X.Org Libraries: libXfont"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXfont-1.5.2.tar.bz2"
  sha256 "02945ea68da447102f3e6c2b896c1d2061fd115de99404facc2aca3ad7010d71"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "d04f3ffd87f700536a78c81686ce027d3baa39dcfc173f911c2036b4ac78c628" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-devel-docs", "Build developer documentation"

  option "with-brewed-zlib", "Use brewed zlib"
  option "with-brewed-bzip2", "Use libbz2 to support bzip2 compressed bitmap fonts"

  depends_on "pkg-config" => :build
  depends_on "xproto"
  depends_on "xtrans" => :build
  depends_on "fontsproto"
  depends_on "libfontenc"
  depends_on "freetype"

  depends_on "bzip2" if build.with?("brewed-bzip2")
  depends_on "zlib"  if build.with?("brewed-zlib")

  if build.with?("devel-docs")

    patch do
      url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
      sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
    end

    depends_on "xmlto" => :build
    depends_on "fop" => :build
    depends_on "xorg-sgml-doctools" => [:build, :recommended]
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
      --enable-devel-docs=#{build.with?("devel-docs") ? "yes" : "no"}
      --with-freetype-config=#{Formula["freetype"].opt_bin}/freetype-config
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end

  test do
    output = shell_output("ldd #{lib}/libXfont.so").chomp
    libs = %w[
      libfontenc.so.1
      libfreetype.so.6
      libpng16.so.16
    ]

    libs.each do |lib|
      assert_match lib, output
    end
  end
end
