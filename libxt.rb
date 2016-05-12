# build a bottle for linuxbrew
class Libxt < Formula
  desc "X.Org Libraries: libXt"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXt-1.1.5.tar.bz2"
  sha256 "46eeb6be780211fdd98c5109286618f6707712235fdd19df4ce1e6954f349f1a"
  # tag "linuxbrew"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-specs",  "Build specifications"
  option "with-glib",   "Build with glib (for unit testing)"

  depends_on "pkg-config" =>  :build

  depends_on "libsm"
  depends_on "libice"
  depends_on "libx11"
  depends_on "xproto"     =>  :build
  depends_on "kbproto"    =>  :build

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

  if build.with?("glib")
    depends_on "glib" => :build
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-appdefaultdir=#{etc}/X11/app-defaults
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
