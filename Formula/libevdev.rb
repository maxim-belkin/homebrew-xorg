class Libevdev < Formula
  desc "Wrapper library for evdev devices"
  homepage "https://www.freedesktop.org/wiki/Software/libevdev/"
  url "https://www.freedesktop.org/software/libevdev/libevdev-1.6.0.tar.xz"
  sha256 "f5005c865987d980cc1279b9ec6131b06a89fd9892f649f2a68262b8786ef814"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "06cfd318090727d4bfbdcb6dac0835b4e1550a310117df2b95ae937f26280735" => :x86_64_linux
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
