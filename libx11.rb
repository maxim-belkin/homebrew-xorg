class Libx11 < Formula
  desc "X.Org Libraries: libX11"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libX11-1.6.4.tar.bz2"
  sha256 "b7c748be3aa16ec2cbd81edc847e9b6ee03f88143ab270fb59f58a044d34e441"
  # tag "linuxbrew"

  bottle do
    sha256 "acfc0cdc997ab0d053a534eb0c951fb0fc6fe5d97a6a66b54db8c6328fb499c9" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-specs",  "Build specifications"

  depends_on "pkg-config" =>  :build
  depends_on "xextproto"  =>  :build
  depends_on "xtrans"     =>  :build
  depends_on "libxcb"
  depends_on "kbproto"    =>  :build
  depends_on "inputproto" =>  :build

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
