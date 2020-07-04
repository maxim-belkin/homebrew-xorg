class Libxext < Formula
  desc "X.Org Libraries: libXext"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXext-1.3.4.tar.bz2"
  sha256 "59ad6fcce98deaecc14d39a672cf218ca37aba617c9a0f691cac3bcd28edf82b"
  # tag "linuxbrew"

  livecheck do
    url "https://ftp.x.org/archive/individual/lib/"
    regex(/libXext-([0-9.]+)\.tar.bz2/)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "e3af172c81646ce9bc6b40c5d28a294d5493286ff80fdddbf53a07a0f43642f2" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-specs", "Build specifications"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/xorgproto"

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/0b466fe45991ae0f8b11a68d8fd0bf48198fc395/Patches/patch_configure.diff"
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
      --enable-specs=#{build.with?("specs") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
