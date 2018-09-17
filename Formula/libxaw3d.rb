class Libxaw3d < Formula
  desc "3D Athena widget set based on the X Toolkit Intrinsics (Xt) library"
  homepage "https://www.x.org"
  url "https://www.x.org/archive/individual/lib/libXaw3d-1.6.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/lib/libXaw3d-1.6.3.tar.bz2"
  sha256 "2dba993f04429ec3d7e99341e91bf46be265cc482df25963058c15f1901ec544"

  bottle do
    sha256 "25a7abe20dd0374befda6986e116c28bce2fe8537470c6648dbd60030e8d2af2" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "without-multiplane-bitmaps", "Build without multiplane bitmaps"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/libxmu"
  depends_on "linuxbrew/xorg/libxt"
  depends_on "linuxbrew/xorg/libx11"
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
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]
    args << "--enable-multiplane-bitmaps" if build.with? "multiplane-bitmaps"

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
