class Libxi < Formula
  desc "X.Org Libraries: libXi"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXi-1.7.8.tar.bz2"
  sha256 "d8f2fa8d53141c41ff521627df9b2fa9c05f6f142fd9881152bab36549ac27bb"
  # tag "linuxbrew"

  bottle do
    cellar :any
    revision 1
    sha256 "90e3d3e41c7e2b0af3eac5d340bdf8a82ff33727cbf3d6d9f250166e8ff2d55a" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-docs",   "Build documentation"
  option "with-specs",  "Build specifications"

  depends_on "pkg-config" => :build

  depends_on "libxfixes"
  depends_on "xextproto" => :build
  depends_on "libxext"
  depends_on "libx11"
  depends_on "xproto" => :build
  depends_on "inputproto" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("docs") || build.with?("specs")
    depends_on "xmlto" => :build
    depends_on "fop" => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "asciidoc" => [:build, :optional]
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
    args << "--enable-docs=#{build.with?("docs") ? "yes" : "no"}"
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
