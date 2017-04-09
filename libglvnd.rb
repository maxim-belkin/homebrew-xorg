class Libglvnd < Formula
  desc "libglvnd: GL Vendor-Neutral Dispatch library"
  homepage "https://github.com/NVIDIA/libglvnd"

  url "https://github.com/NVIDIA/libglvnd.git"
  version "07262016"

  option "with-static",   "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build

  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/glproto" => :build

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

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
