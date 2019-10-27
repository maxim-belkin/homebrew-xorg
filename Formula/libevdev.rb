class Libevdev < Formula
  desc "Wrapper library for evdev devices"
  homepage "https://www.freedesktop.org/wiki/Software/libevdev/"
  url "https://www.freedesktop.org/software/libevdev/libevdev-1.8.0.tar.xz"
  sha256 "20d3cae4efd277f485abdf8f2a7c46588e539998b5a08c2c4d368218379d4211"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "c3558f89cff61d7ba38f1c9f80d30ea9c676cd73d5ef6155517c3358667c13f7" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"
  option "without-test", "Skip compile-time tests"
  option "with-python@2", "Build with Python 2"

  depends_on "check" => :build if build.with? "test"
  depends_on "pkg-config" => :build
  depends_on "python" => :build if build.without? "python@2"
  depends_on "python@2" => [:build, :optional]

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
