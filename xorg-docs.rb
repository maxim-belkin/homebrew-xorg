class XorgDocs < Formula
  desc "Xorg ocumentation that doesn't better fit into other packages"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://www.x.org/archive/individual/doc/xorg-docs-1.7.tar.bz2"
  sha256 "b9b1918bd365e9eb29c325e76bb8c4d774d37be707e433fb0af94da35683375f"
  # tag "linuxbrew"

  # unlike other packages, this one is all about documentation
  # so we build docs + specs unless requested otherwise
  option "without-docs",  "Do not build documentation"
  option "without-specs", "Do not build specifications"
  option "with-check",    "Run a check before installation"

  depends_on "util-macros" => [:build, :recommended]
  depends_on "xmlto"       => [:build, :recommended]
  depends_on "fop"         => [:build, :recommended]
  depends_on "libxslt"     => [:build, :recommended]
  depends_on "xorg-sgml-doctools" => [:build, :recommended]

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--prefix=#{prefix}"

    # Be explicit about the configure flags
    args << "--enable-docs=#{build.without?("docs") ? "no" : "yes"}"
    args << "--enable-specs=#{build.without?("specs") ? "no" : "yes"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("check")
    system "make", "install"
  end
end
