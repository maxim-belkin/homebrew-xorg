class Libxaw3d < Formula
  desc "3D Athena widget set based on the X Toolkit Intrinsics (Xt) library"
  homepage "https://www.x.org"
  url "https://www.x.org/archive/individual/lib/libXaw3d-1.6.2.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/lib/libXaw3d-1.6.2.tar.bz2"
  sha256 "b74f11681061c1492c03cbbe6e318f9635b3877af0761fc0e67e1467c3a6972b"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "without-multiplane-bitmaps", "Build without multiplane bitmaps"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxt"
  depends_on "linuxbrew/xorg/libxmu"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxpm" if build.with? "multiplane-bitmaps"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-gray-stipples
      --enable-arrow-scrollbars
    ]
    args << "--enable-multiplane-bitmaps" if build.with? "multiplane-bitmaps"
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"
    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <X11/Xaw3d/Label.h>
      int main() { printf("%d", sizeof(LabelWidget)); }
    EOS
    system ENV.cc, "test.c", "-o", "test"
    output = shell_output("./test").chomp
    assert_match "8", output
  end
end
