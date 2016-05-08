# libxaw: Build a bottle for Linuxbrew
class Libxaw < Formula
  desc "X.Org Libraries: libXaw"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXaw-1.0.13.tar.bz2"
  sha256 "8ef8067312571292ccc2bbe94c41109dcf022ea5a4ec71656a83d8cce9edb0cd"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries (not recommended)"
  option "with-specs",  "Build specifications"

  depends_on "pkg-config" =>  :build
  depends_on "xproto"     =>  :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "xextproto"  =>  :build
  depends_on "libxt"
  depends_on "libxmu"
  depends_on "libxpm"

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("specs")
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
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("check")
    system "make", "install"
  end
end
