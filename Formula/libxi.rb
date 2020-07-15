class Libxi < Formula
  desc "X.Org Libraries: libXi"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXi-1.7.10.tar.bz2"
  sha256 "36a30d8f6383a72e7ce060298b4b181fd298bc3a135c8e201b7ca847f5f81061"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "945af08c6e1d961e3f06fe14d735208ed2979a84bc62315b057bfeb61bff8bae" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-docs", "Build documentation"
  option "with-specs", "Build specifications"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxfixes"
  depends_on "linuxbrew/xorg/xorgproto"

  if build.with?("docs") || build.with?("specs")

    patch do
      url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/0b466fe45991ae0f8b11a68d8fd0bf48198fc395/Patches/patch_configure.diff"
      sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
    end

    depends_on "xmlto" => :build
    depends_on "fop" => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "asciidoc" => [:build, :optional]
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
