class Libevdev < Formula
  desc "Wrapper library for evdev devices"
  homepage "https://www.freedesktop.org/wiki/Software/libevdev/"
  url "https://www.freedesktop.org/software/libevdev/libevdev-1.8.0.tar.xz"
  sha256 "20d3cae4efd277f485abdf8f2a7c46588e539998b5a08c2c4d368218379d4211"
  revision 1

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "8abd44da45643c87e55d16293c3cb62d4257a87a7fc7d48fb03c77eaefd9e948" => :x86_64_linux
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
