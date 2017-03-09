class Libxrandr < Formula
  desc "X.Org Libraries: libXrandr"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXrandr-1.5.1.tar.bz2"
  sha256 "1ff9e7fa0e4adea912b16a5f0cfa7c1d35b0dcda0e216831f7715c8a3abcf51a"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "e8bc7002f599d1f9cd80b95441a3287d26cbe91147e3c80b27d5e90dfc9e5491" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/randrproto" => :build
  depends_on "linuxbrew/xorg/xextproto" => :build
  depends_on "linuxbrew/xorg/renderproto" => :build

  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxrender"

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
