class XcbProto < Formula
  desc "XML-XCB protocol descriptions that libxcb uses for code generation"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "https://xcb.freedesktop.org/dist/xcb-proto-1.11.tar.bz2"
  sha256 "b4aceee6502a0ce45fc39b33c541a2df4715d00b72e660ebe8c5bb444771e32e"
  # tag "linuxbrew"

  bottle do
    sha256 "23ccadabc4d8eb1d9a396c6c6ed1391b5ac0af0296246773a3fccf08ed9dda21" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-python3", "Build with python3 (default version is used otherwise)"

  depends_on "pkg-config"  => :build

  if build.with?("python3")
    depends_on :python3      => :build
  else
    depends_on :python       => :build
  end

  depends_on "libxml2"    => :build if build.with?("test") # to run tests

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]

    if build.with?("python3")
      ENV["PYTHON"] = "python3"
    end
    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
