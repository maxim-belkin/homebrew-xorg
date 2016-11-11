class Libxrandr < Formula
  desc "X.Org Libraries: libXrandr"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXrandr-1.5.0.tar.bz2"
  sha256 "6f864959b7fc35db11754b270d71106ef5b5cf363426aa58589cb8ac8266de58"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "6d362e11582df8ff7a9e48c24fd2708287184e82fd82909fccfc55c270d13dd9" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "randrproto" => :build
  depends_on "xextproto" => :build
  depends_on "renderproto" => :build

  depends_on "libxext"
  depends_on "libxrender"

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
