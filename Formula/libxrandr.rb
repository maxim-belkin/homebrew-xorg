class Libxrandr < Formula
  desc "X.Org Libraries: libXrandr"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXrandr-1.5.2.tar.bz2"
  sha256 "8aea0ebe403d62330bb741ed595b53741acf45033d3bda1792f1d4cc3daee023"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "e8bc7002f599d1f9cd80b95441a3287d26cbe91147e3c80b27d5e90dfc9e5491" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxrender"
  depends_on "linuxbrew/xorg/xorgproto"

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
