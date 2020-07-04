class Libice < Formula
  desc "X.Org Libraries: libICE"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libICE-1.0.10.tar.bz2"
  sha256 "6f86dce12cf4bcaf5c37dddd8b1b64ed2ddf1ef7b218f22b9942595fb747c348"
  # tag "linuxbrew"

  livecheck do
    url "https://ftp.x.org/archive/individual/lib/"
    regex(/libICE-([0-9.]+)\.tar.bz2/)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "23a15495adac70a5fb0fbdcbf2edf956ef4178d1859d5d78ec83cdeaf9ac3669" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-docs", "Build documentation"
  option "with-specs", "Build specifications"

  # Required dependencies
  depends_on "linuxbrew/xorg/xtrans" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xorgproto"

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/0b466fe45991ae0f8b11a68d8fd0bf48198fc395/Patches/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("docs") || build.with?("specs")
    depends_on "xmlto" => :build
    depends_on "fop"     => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => [:build, :recommended]
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-docs=#{build.with?("docs") ? "yes" : "no"}
      --enable-specs=#{build.with?("specs") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
