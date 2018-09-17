class Libxres < Formula
  desc "X.Org Libraries: libXres"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXres-1.2.0.tar.bz2"
  sha256 "ff75c1643488e64a7cfbced27486f0f944801319c84c18d3bd3da6bf28c812d4"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "0985d29cbc53e7afdf8b0f01acc5ad3b39bdd9a036a0f773f25c6199b97fc5fe" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/resourceproto" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"

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
