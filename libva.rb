class Libva < Formula
  desc "Hardware accelerated video processing library"
  homepage "http://www.freedesktop.org/"
  url "http://www.freedesktop.org/software/vaapi/releases/libva/libva-1.7.2.tar.bz2"
  sha256 "5dd61cf16a5648b680e6146a58064e93be11bf4e65a9e4e30f1e9cb8ecfa2c13"

  option "with-static", "Build static libraries (not recommended)"

  #
  # Trivia:
  # There is a circular dependency with Mesa.
  #
  # Libva should be installed:
  #  1. before Mesa with "disable-egl" and "disable-egl" options ~> this package
  #  2. after  Mesa without the above options.
  #
  # The second installations is hard-coded into Mesa as a post-installation step
  #

  # Build-time
  depends_on "pkg-config" => :build
  depends_on "autoconf"   => :build

  # Required
  depends_on "libdrm"

  # recommended
  depends_on "wayland" => :recommended
  # depends_on "xorg"    => :recommended

  # optional
  # depends_on "doxygen" => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    args << "--disable-egl"
    args << "--disable-glx"

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "autoreconf", "-fi" if build.without?("wayland") # needed only if Wayland is not installed
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
