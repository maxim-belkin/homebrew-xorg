class Libxfont2 < Formula
  desc "X.Org Libraries: libXfont"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXfont2-2.0.3.tar.bz2"
  sha256 "0e8ab7fd737ccdfe87e1f02b55f221f0bd4503a1c5f28be4ed6a54586bac9c4e"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "c7764e28017af5e715807d90237d2103637ffd9d5d17976f082f5a53659d1635" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-devel-docs", "Build developer documentation"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/fontsproto" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/xtrans" => :build
  depends_on "bzip2"
  depends_on "freetype"
  depends_on "zlib"
  depends_on "linuxbrew/xorg/libfontenc"

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
