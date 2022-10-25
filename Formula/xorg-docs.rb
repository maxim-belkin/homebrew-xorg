class XorgDocs < Formula
  desc "X.Org ocumentation that is not part of other Xorg packages"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/doc/xorg-docs-1.7.2.tar.bz2"
  sha256 "2391b8af472626c12d3c3814b5e7a0ea43c3a96eda94255b7ed8bdff0fbf08e3"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "58452a7b0914fd3c8b5c7f660b1f6b145f62453184aac810fecb67884ea3186d"
  end

  # unlike other packages, this one is all about documentation
  # so we build docs + specs unless requested otherwise
  option "without-docs", "Do not build documentation"
  option "without-specs", "Do not build specifications"
  option "without-test", "Skip compile-time testsation"

  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build
  depends_on "fop" => :build
  depends_on "libxslt" => :build
  depends_on "lynx" => :build
  depends_on "maxim-belkin/xorg/xorg-sgml-doctools" => :build
  depends_on "openjdk" => :build
  depends_on "pkg-config" => :build # required for xmlto to work correctly
  depends_on "util-macros" => :build
  depends_on "xmlto" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/0b466fe45991ae0f8b11a68d8fd0bf48198fc395/Patches/patch_configure.diff"
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
