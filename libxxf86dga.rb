class Libxxf86dga < Formula
  desc "X.Org Libraries: libXxf86dga"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXxf86dga-1.1.4.tar.bz2"
  sha256 "8eecd4b6c1df9a3704c04733c2f4fa93ef469b55028af5510b25818e2456c77e"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "1cdae212078b6d5a2e3921938a54096390fa46ca13190a40b0e80c5bd6b596a7" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/xproto"     => :build
  depends_on "linuxbrew/xorg/xextproto"  => :build
  depends_on "linuxbrew/xorg/xf86dgaproto" => :build

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
