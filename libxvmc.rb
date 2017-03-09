class Libxvmc < Formula
  desc "X.Org Libraries: libXvMC"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXvMC-1.0.10.tar.bz2"
  sha256 "e501a079b5dfaef0897c56152770c77e05e362065cec58910289aa567277ee2e"
  # tag "linuxbrew"

  bottle do
    sha256 "e28b6997a113d97a09dee052ff366737922d2ad9ecd7c5e69ea603e78d07d776" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxv"
  depends_on "linuxbrew/xorg/xextproto" => :build
  depends_on "linuxbrew/xorg/videoproto" => :build

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
