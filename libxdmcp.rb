class Libxdmcp < Formula
  desc "X Display Manager Control Protocol"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXdmcp-1.1.2.tar.bz2"
  sha256 "81fe09867918fff258296e1e1e159f0dc639cb30d201c53519f25ab73af4e4e2"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "b6ce973996bb3bee6493bf298605cabdebb538ff3092d97e9b98f2eeb7f24da3" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-docs", "Build documentation"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xorg-protocols" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("docs")
    depends_on "xmlto" => :build
    depends_on "fop" => %i(build recommended)
    depends_on "libxslt" => %i(build recommended)
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => %i(build recommended)
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

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
