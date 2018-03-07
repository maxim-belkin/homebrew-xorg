class XcbProto < Formula
  desc "XML-XCB protocol descriptions that libxcb uses for code generation"
  homepage "https://www.x.org/"
  url "https://xcb.freedesktop.org/dist/xcb-proto-1.12.tar.bz2"
  sha256 "5922aba4c664ab7899a29d92ea91a87aa4c1fc7eb5ee550325c3216c480a4906"
  revision 2
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
  end

  option "with-test", "Skip compile-time tests"
  option "with-python3", "Build with python3 (default version is used otherwise)"

  depends_on "pkg-config" => :build
  depends_on "libxml2" => :build if build.with? "test"
  depends_on "python@2" => [:build] unless which "python2.7"

  patch :p1 do
    url "http://www.linuxfromscratch.org/patches/blfs/svn/xcb-proto-1.12-python3-1.patch"
    sha256 "4eef0285392c525fcb7aeb54c1b6dc8406dc33c5845c1311b65b3efc409bea2e"
  end

  patch :p1 do
    url "http://www.linuxfromscratch.org/patches/blfs/svn/xcb-proto-1.12-schema-1.patch"
    sha256 "3bc1a1871d17325d1f591a8ec2091f956b2071d83a6e9998d7d4880c4abf3e8b"
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
