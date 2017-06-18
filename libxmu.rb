class Libxmu < Formula
  desc "X.Org Libraries: libXmu"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXmu-1.1.2.tar.bz2"
  sha256 "756edc7c383254eef8b4e1b733c3bf1dc061b523c9f9833ac7058378b8349d0b"
  # tag "linuxbrew"

  bottle do
    rebuild 1
    sha256 "2b0c683b9deddbed3c238bf167b96ada9e76587f22ed0a8d28d8f87955d38e20" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-docs", "Build documentation"

  depends_on "pkg-config" => :build

  depends_on "linuxbrew/xorg/libxt"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/xextproto" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("docs")
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
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"
    args << "--enable-docs=#{build.with?("docs") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
