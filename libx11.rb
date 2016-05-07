# libx11: Build a bottle for Linuxbrew
class Libx11 < Formula
  desc "X.Org Libraries: libX11"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libX11-1.6.3.tar.bz2"
  sha256 "cf31a7c39f2f52e8ebd0db95640384e63451f9b014eed2bb7f5de03e8adc8111"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries (not recommended)"
  option "with-specs",  "Build specifications"

  depends_on "pkg-config" =>  :build
  depends_on "xextproto"  =>  :build
  depends_on "xtrans"     =>  :build
  depends_on "libxcb"
  depends_on "kbproto"    =>  :build
  depends_on "inputproto" =>  :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("specs")
    depends_on "xmlto"   => :build
    depends_on "fop"     => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "perl"    => [:build, :optional]
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
