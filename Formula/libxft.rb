class Libxft < Formula
  desc "X.Org Libraries: libXft"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXft-2.3.3.tar.bz2"
  sha256 "225c68e616dd29dbb27809e45e9eadf18e4d74c50be43020ef20015274529216"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "1c214681d1f4ec2feacdf2bd6bd24d9e51b22d24aa2b191c2eda87d85aba0f82" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-brewed-bzip2", "Use brewed bzip2"
  option "with-brewed-zlib", "Use brewed zlib"

  depends_on "pkg-config" => :build

  depends_on "bzip2" if build.with? "brewed-bzip2"
  depends_on "fontconfig"
  depends_on "linuxbrew/xorg/libxrender"
  depends_on "zlib" if build.with? "brewed-zlib"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
