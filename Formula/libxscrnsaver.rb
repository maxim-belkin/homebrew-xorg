class Libxscrnsaver < Formula
  desc "X.Org Libraries: libXScrnSaver"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXScrnSaver-1.2.3.tar.bz2"
  sha256 "f917075a1b7b5a38d67a8b0238eaab14acd2557679835b154cf2bca576e89bf8"
  # tag "linuxbrew"

  livecheck do
    url "https://ftp.x.org/archive/individual/lib/"
    regex(/libXScrnSaver-([0-9.]+)\.tar.bz2/)
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "201bfe6a40c71968795a354c8ea51703cff91483a3ec9bbc271e967f8b5e2205" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/xorgproto"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
