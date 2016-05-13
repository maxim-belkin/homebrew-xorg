# xcb-proto: Build a bottle for Linuxbrew
class XcbProto < Formula
  desc "XML-XCB protocol descriptions that libxcb uses to generate the majority of its code and API"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://xcb.freedesktop.org/dist/xcb-proto-1.11.tar.bz2"
  sha256 "b4aceee6502a0ce45fc39b33c541a2df4715d00b72e660ebe8c5bb444771e32e"
  # tag "linuxbrew"

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
