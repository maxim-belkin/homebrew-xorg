class Libxvmc < Formula
  desc "X.Org Libraries: libXvMC"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXvMC-1.0.12.tar.bz2"
  sha256 "6b3da7977b3f7eaf4f0ac6470ab1e562298d82c4e79077765787963ab7966dcd"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "c662b1deecbc380ded8770f5b9ccfc7f7bac6b75f0a3caec1439e94a42357a83" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxv"

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
