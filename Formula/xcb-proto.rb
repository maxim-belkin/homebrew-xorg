class XcbProto < Formula
  desc "XML-XCB protocol descriptions that libxcb uses for code generation"
  homepage "https://www.x.org/"
  url "https://xcb.freedesktop.org/dist/xcb-proto-1.13.tar.bz2"
  sha256 "7b98721e669be80284e9bbfeab02d2d0d54cd11172b72271e47a2fe875e2bde1"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "659fa66505b5bb4d6774640fd21b379581c6c4703319e4cc95ded297f4eba8bb" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-python@2", "Build with Python 2"

  depends_on "pkg-config" => :build
  depends_on "libxml2" => :build if build.with? "test"
  depends_on "python@2" => [:build, :optional]
  depends_on "python" => :build if build.without? "python@2"

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
