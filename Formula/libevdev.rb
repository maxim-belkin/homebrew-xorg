class Libevdev < Formula
  desc "Wrapper library for evdev devices"
  homepage "https://www.freedesktop.org/wiki/Software/libevdev/"
  url "https://www.freedesktop.org/software/libevdev/libevdev-1.8.0.tar.xz"
  sha256 "20d3cae4efd277f485abdf8f2a7c46588e539998b5a08c2c4d368218379d4211"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "08d21f1843c9b17113b4b349098ac762d14222e1f1028302115ff537e82b048b" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

  depends_on "check" => :build if build.with? "test"
  depends_on "pkg-config" => :build
  depends_on "python" => :build

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
