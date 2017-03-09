class Libfs < Formula
  desc "X.Org Libraries: libFS"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libFS-1.0.7.tar.bz2"
  sha256 "2e9d4c07026a7401d4fa4ffae86e6ac7fec83f50f3268fa85f52718e479dc4f3"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "cd6286cff0b75492f2ccf77ed7b9a26b0f89f75d178a8b60e660a77bb8710620" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" =>  :build

  depends_on "linuxbrew/xorg/xproto"     =>  :build
  depends_on "linuxbrew/xorg/fontsproto" =>  :build
  depends_on "linuxbrew/xorg/xtrans"     =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
