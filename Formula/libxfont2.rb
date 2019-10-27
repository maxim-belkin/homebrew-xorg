class Libxfont2 < Formula
  desc "X.Org Libraries: libXfont"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXfont2-2.0.4.tar.bz2"
  sha256 "6d151b3368e5035efede4b6264c0fdc6662c1c99dbc2de425e3480cababc69e6"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "ffb4e3a1d6c765a68a6025e7b4eab03d252b2bb187e25dce0e6af28d28a299ed" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-devel-docs", "Build developer documentation"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xtrans" => :build
  depends_on "pkg-config" => :build
  depends_on "bzip2"
  depends_on "freetype"
  depends_on "linuxbrew/xorg/libfontenc"
  depends_on "linuxbrew/xorg/xorgproto"
  depends_on "zlib"

  if build.with? "devel-docs"
    depends_on :java => :build
    depends_on "docbook" => :build
    depends_on "docbook-xsl" => :build
    depends_on "libxslt" => :build
    depends_on "xmlto" => :build
    depends_on "lynx" => :build # required for xmlto to work correctly
    depends_on "fop" => :build
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => :build
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
      --with-bzip2
    ]

    # ensure we can find the docbook XML tags
    ENV["XML_CATALOG_FILES"] = etc/"xml/catalog" if build.with? "devel-docs"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
    pkgshare.install Dir["doc/*.{pdf,html,ps,txt}"] if build.with? "devel-docs"
  end

  test do
    output = shell_output("ldd #{lib}/libXfont2.so").chomp
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
