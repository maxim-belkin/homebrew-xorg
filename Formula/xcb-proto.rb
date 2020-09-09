class XcbProto < Formula
  desc "XML-XCB protocol descriptions that libxcb uses for code generation"
  homepage "https://www.x.org/"
  url "https://xcb.freedesktop.org/dist/xcb-proto-1.13.tar.bz2"
  sha256 "7b98721e669be80284e9bbfeab02d2d0d54cd11172b72271e47a2fe875e2bde1"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "fa7cc6cc3a57e41ce388e0326969f91a4ccf7da19dea778652d4b25ec809ea60" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

  depends_on "libxml2" => :build if build.with? "test"
  depends_on "pkg-config" => [:build, :test]
  depends_on "python@3.8" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
      PYTHON=python3
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  test do
    assert_equal "#{share}/xcb", shell_output("pkg-config --variable=xcbincludedir xcb-proto").chomp
  end
end
