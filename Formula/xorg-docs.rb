class XorgDocs < Formula
  desc "X.Org ocumentation that is not part of other Xorg packages"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/doc/xorg-docs-1.7.1.tar.bz2"
  sha256 "24b8677c3462c10465cf50d40576d76682acd5835526093a575865b2aa242c4b"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "92ae6d07bfe4465a33e050a408ca9f5f6d3c6b90e8334055d7e885a3ca37a8bd" => :x86_64_linux
  end

  # unlike other packages, this one is all about documentation
  # so we build docs + specs unless requested otherwise
  option "without-docs", "Do not build documentation"
  option "without-specs", "Do not build specifications"
  option "without-test", "Skip compile-time testsation"

  depends_on :java => :build
  depends_on "pkg-config" => :build
  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build
  depends_on "fop" => :build
  depends_on "libxslt" => :build
  depends_on "lynx" => :build # required for xmlto to work correctly
  depends_on "xmlto" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xorg-sgml-doctools" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/Patches/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xmlto=yes
      --with-fop=yes
      --enable-docs=#{build.with?("docs") ? "yes" : "no"}
      --enable-specs=#{build.with?("specs") ? "yes" : "no"}
    ]

    # ensure we can find the docbook XML tags
    ENV["XML_CATALOG_FILES"] = etc/"xml/catalog"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
