# xtrans: Build a bottle for Linuxbrew
class Xtrans < Formula
  desc "X.Org Libraries: xtrans"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/xtrans-1.3.5.tar.bz2"
  sha256 "adbd3b36932ce4c062cd10f57d78a156ba98d618bdb6f50664da327502bc8301"
  # tag "linuxbrew"

  option "with-docs", "Build documentation"

  depends_on "pkg-config" =>  :build

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
    args << "--enable-docs=#{build.with?("docs") ? "yes" : "no"}"

    system "./configure", *args
    system "make", "install"
  end
end
