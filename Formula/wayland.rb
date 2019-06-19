class Wayland < Formula
  desc "Protocol for a compositor to talk to its clients"
  homepage "https://wayland.freedesktop.org"
  url "https://wayland.freedesktop.org/releases/wayland-1.17.0.tar.xz"
  sha256 "72aa11b8ac6e22f4777302c9251e8fec7655dc22f9d94ee676c6b276f95f91a4"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "ed45d0f9392c0add5fdc2e25b91e2bd450752ed34f2d69feb8151ccb697b0236" => :x86_64_linux
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
