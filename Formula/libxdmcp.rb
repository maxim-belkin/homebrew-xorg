class Libxdmcp < Formula
  desc "X Display Manager Control Protocol"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXdmcp-1.1.3.tar.bz2"
  sha256 "20523b44aaa513e17c009e873ad7bbc301507a3224c232610ce2e099011c6529"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "f8d257f11b6b31026b006a1a5fcc577a9fe0def4e73e9657d377a4e431ee6706" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-docs", "Build documentation"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xorgproto"

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/0b466fe45991ae0f8b11a68d8fd0bf48198fc395/Patches/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with? "docs"
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
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
