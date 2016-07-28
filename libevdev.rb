# libevdev: Build a bottle for Linuxbrew
class Libevdev < Formula
  desc "Wrapper library for evdev devices"
  homepage "http://www.freedesktop.org"
  url    "https://www.freedesktop.org/software/libevdev/libevdev-1.2.2.tar.xz"
  sha256 "860e9a1d5594393ff1f711cdeaf048efe354992019068408abbcfa4914ad6709"
  # tag "linuxbrew"

  option "with-static", "Build static libraries (not recommended)"
  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" =>  :build
  depends_on :python => :build
  depends_on "check" => :build if build.with?("test")

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "test" if build.with?("test")
    system "make", "install"
  end

  test do
    output = shell_output("ldd #{bin}/touchpad-edge-detector").chomp
    assert_match "lib/libevdev.so.2", output
  end
end
