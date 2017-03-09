class Libxi < Formula
  desc "X.Org Libraries: libXi"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXi-1.7.9.tar.bz2"
  sha256 "c2e6b8ff84f9448386c1b5510a5cf5a16d788f76db018194dacdc200180faf45"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "84d0e465048c45d9236563a7803716fcb0bdafbbcf670992653fdcab6ca68d84" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-docs",   "Build documentation"
  option "with-specs",  "Build specifications"

  depends_on "pkg-config" => :build

  depends_on "linuxbrew/xorg/libxfixes"
  depends_on "linuxbrew/xorg/xextproto" => :build
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/inputproto" => :build


  if build.with?("docs") || build.with?("specs")

    patch do
      url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
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
      --enable-static=#{build.with?("static") ? "yes" : "no"}
      --enable-docs=#{build.with?("docs") ? "yes" : "no"}
      --enable-specs=#{build.with?("specs") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
