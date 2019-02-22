class Wayland < Formula
  desc "Protocol for a compositor to talk to its clients"
  homepage "https://wayland.freedesktop.org"
  url "https://wayland.freedesktop.org/releases/wayland-1.16.91.tar.xz"
  sha256 "d51b83a51034ed5474517e0b0bca2d4e7056e4c51d720ea885f0c34f243fee90"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "1fe8ccc36b0538e1a6d067c9763fef08ddbdaa5abba9b65fa2f436651fd58cd9" => :x86_64_linux
  end

  head do
    url "git://anongit.freedesktop.org/wayland/wayland"
  end

  option "with-static", "Build static libraries (not recommended)"
  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
  depends_on "autoconf" if build.head?
  depends_on "expat"
  depends_on "libffi"
  depends_on "libxml2"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-documentation
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end
    system "make"
    ENV.deparallelize
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
