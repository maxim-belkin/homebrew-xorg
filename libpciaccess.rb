class Libpciaccess < Formula
  desc "X.Org Libraries: libpciaccess"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libpciaccess-0.13.4.tar.bz2"
  sha256 "07f864654561e4ac8629a0ef9c8f07fbc1f8592d1b6c418431593e9ba2cf2fcf"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "b0ce22591ed9ec00fccd13a08bb10d93f4b786a4554dba9cd476702c82b8039d" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--disable-static" if build.without?("static")

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
