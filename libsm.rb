# libsm: Build a bottle for Linuxbrew
class Libsm < Formula
  desc "X.Org Libraries: libSM"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libSM-1.2.2.tar.bz2"
  sha256 "0baca8c9f5d934450a70896c4ad38d06475521255ca63b717a6510fdb6e287bd"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries (not recommended)"
  option "with-docs",   "Build documentation"

  depends_on "pkg-config" =>  :build
  depends_on "xproto"     =>  :build
  depends_on "libice"
  depends_on "xtrans"     =>  :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("docs")
    depends_on "xmlto"   => :build
    depends_on "fop"     => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
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

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("check")
    system "make", "install"
  end
end
