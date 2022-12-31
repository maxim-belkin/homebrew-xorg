class Libevdev < Formula
  desc "Wrapper library for evdev devices"
  homepage "https://www.freedesktop.org/wiki/Software/libevdev/"
  url "https://www.freedesktop.org/software/libevdev/libevdev-1.13.0.tar.xz"
  sha256 "9edf2006cc86a5055279647c38ec923d11a821ee4dc2c3033e8d20e8ee237cd9"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b77d1cae308fb60f8e7d32dd2495d50f5625449ae85a42bb0008ec7843d39ee0"
  end

  option "without-test", "Skip compile-time tests"

  depends_on "check" => :build if build.with? "test"
  depends_on "pkg-config" => :build
  depends_on "python@3.8" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  test do
    files = ["touchpad-edge-detector", "mouse-dpi-tool", "libevdev-tweak-device"]
    files.each do |f|
      output = shell_output("ldd #{bin}/#{f}").chomp
      assert_match "lib/libevdev.so.2", output
    end
  end
end
