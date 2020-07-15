class Libxt < Formula
  desc "X.Org Libraries: libXt"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXt-1.2.0.tar.bz2"
  sha256 "b31df531dabed9f4611fc8980bc51d7782967e2aff44c4105251a1acb5a77831"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "ca44976ced1812ee671599b1476f2579bd55790a771b66ef6a2c1ef3fe07c3b8" => :x86_64_linux
  end

  option "with-test", "Run compile-time tests"
  option "with-specs", "Build specifications"

  depends_on "glib" => :build if build.with? "test"
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libice"
  depends_on "linuxbrew/xorg/libsm"
  depends_on "linuxbrew/xorg/libx11"

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/0b466fe45991ae0f8b11a68d8fd0bf48198fc395/Patches/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with? "specs"
    depends_on "xmlto" => :build
    depends_on "fop"     => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "perl"    => [:build, :optional]
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => [:build, :recommended]
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-appdefaultdir=#{etc}/X11/app-defaults
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-specs=#{build.with?("specs") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
