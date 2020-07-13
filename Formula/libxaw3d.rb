class Libxaw3d < Formula
  desc "3D Athena widget set based on the X Toolkit Intrinsics (Xt) library"
  homepage "https://www.x.org"
  url "https://www.x.org/archive/individual/lib/libXaw3d-1.6.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/lib/libXaw3d-1.6.3.tar.bz2"
  sha256 "2dba993f04429ec3d7e99341e91bf46be265cc482df25963058c15f1901ec544"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "b16f1cb6c8c7a86c998e3a0b5b8d42827755a755411632dc005d82d2eb612d3f" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  deprecated_option "without-multiplane-bitmaps" => "without-libxpm"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxmu"
  depends_on "linuxbrew/xorg/libxt"
  depends_on "linuxbrew/xorg/libxpm" => :recommended

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
    args << "--enable-multiplane-bitmaps" if build.with? "libxpm"

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
