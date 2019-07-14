class Libxext < Formula
  desc "X.Org Libraries: libXext"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXext-1.3.4.tar.bz2"
  sha256 "59ad6fcce98deaecc14d39a672cf218ca37aba617c9a0f691cac3bcd28edf82b"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "00ba831ed41f21fa1f0bbdbff41db6a6bb8c188b99f2665369aa0cbe3ec94ac1" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-specs", "Build specifications"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/xorgproto"

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/Patches/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with? "specs"
    depends_on "xmlto" => :build
    depends_on "lynx" => :build
    depends_on "libxslt" => :build
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => :build
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
      --enable-specs=#{build.with?("specs") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
