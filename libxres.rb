class Libxres < Formula
  desc "X.Org Libraries: libXres"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXres-1.0.7.tar.bz2"
  sha256 "26899054aa87f81b17becc68e8645b240f140464cf90c42616ebb263ec5fa0e5"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "0985d29cbc53e7afdf8b0f01acc5ad3b39bdd9a036a0f773f25c6199b97fc5fe" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/xextproto" => :build
  depends_on "linuxbrew/xorg/resourceproto" => :build

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
