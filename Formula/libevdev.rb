class Libevdev < Formula
  desc "Wrapper library for evdev devices"
  homepage "https://www.freedesktop.org/wiki/Software/libevdev/"
  url "https://www.freedesktop.org/software/libevdev/libevdev-1.5.9.tar.xz"
  sha256 "e1663751443bed9d3e76a4fe2caf6fa866a79705d91cacad815c04e706198a75"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "8038685697da557b2190dd043035c21149c813e6c56582971db9eba81ebd07c3" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"
  option "without-test", "Skip compile-time tests"
  option "with-python@2", "Build with Python 2"

  depends_on "pkg-config" => :build
  depends_on "check" => :build if build.with? "test"
  depends_on "python@2" => [:build, :optional]
  depends_on "python" => :build if build.without? "python@2"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
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
