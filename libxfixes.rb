class Libxfixes < Formula
  desc "X.Org Libraries: libXfixes"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXfixes-5.0.3.tar.bz2"
  sha256 "de1cd33aff226e08cefd0e6759341c2c8e8c9faf8ce9ac6ec38d43e287b22ad6"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "de00528cfeec544e7e0a6dea7be947dc098440268002f68f215587a10e692ce9" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xproto"     => :build
  depends_on "linuxbrew/xorg/fixesproto" => :build
  depends_on "linuxbrew/xorg/xextproto"  => :build
  depends_on "linuxbrew/xorg/libx11"

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
