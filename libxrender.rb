class Libxrender < Formula
  desc "X.Org Libraries: libXrender"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXrender-0.9.9.tar.bz2"
  sha256 "fc2fe57980a14092426dffcd1f2d9de0987b9d40adea663bd70d6342c0e9be1a"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "86916def7aab225ce04748be225dee617ee71369df774bcbbc1d1117cede3b65" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "libx11"
  depends_on "renderproto" => :build

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
