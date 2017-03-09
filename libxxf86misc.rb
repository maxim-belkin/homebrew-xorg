class Libxxf86misc < Formula
  desc "X.Org Libraries: libXxf86misc"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "https://www.x.org/archive//individual/lib/libXxf86misc-1.0.3.tar.gz"
  sha256 "358f692f793af00f6ef4c7a8566c1bcaeeea37e417337db3f519522cc1df3946"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "b93c3e0e6f73b9e19682b33f58ab6ebe836fd3918a3c6b15ec4ff7bd588c39e3" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" =>  :build

  depends_on "linuxbrew/xorg/xproto"     =>  :build
  depends_on "linuxbrew/xorg/xextproto"  =>  :build
  depends_on "linuxbrew/xorg/xf86miscproto" =>  :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"

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
