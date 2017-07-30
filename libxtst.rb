class Libxtst < Formula
  desc "X.Org Libraries: libXtst"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXtst-1.2.3.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/lib/libXtst-1.2.3.tar.bz2"
  sha256 "4655498a1b8e844e3d6f21f3b2c4e2b571effb5fd83199d428a6ba7ea4bf5204"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "883e02960643d1b58e7a2cd860f7c2d4bc3e77c38ca5b2216a24a4593a93852b" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-specs", "Build specifications"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libxi"

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("specs")
    depends_on "xmlto" => :build
    depends_on "fop" => [:build, :recommended]
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
