# libice: Build a bottle for Linuxbrew
class Libice < Formula
  desc "X.Org Libraries: libICE"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libICE-1.0.9.tar.bz2"
  sha256 "8f7032f2c1c64352b5423f6b48a8ebdc339cc63064af34d66a6c9aa79759e202"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries (not recommended)"
  option "with-docs",   "Build documentation"
  option "with-specs",  "Build specifications"

  # Required dependencies
  depends_on "pkg-config" =>  :build
  depends_on "xproto"     =>  :build
  depends_on "xtrans"     =>  :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("docs") or build.with?("specs")
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
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("check")
    system "make", "install"
  end
end
