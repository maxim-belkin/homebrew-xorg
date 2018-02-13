class Libxfontcache < Formula
  desc "X.Org Libraries: libXfontCache"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive//individual/lib/libXfontcache-1.0.5.tar.gz"
  sha256 "fdba75307a0983d2566554e0e9effa7079551f1b7b46e8de642d067998619659"
  # tag "linuxbrew"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  # Required dependencies
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xextproto" => :build
  depends_on "linuxbrew/xorg/fontcacheproto" => :build
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
