class WaylandProtocols < Formula
  desc "Additional Wayland protocols"
  homepage "https://wayland.freedesktop.org"
  url "https://wayland.freedesktop.org/releases/wayland-protocols-1.17.tar.xz"
  sha256 "df1319cf9705643aea9fd16f9056f4e5b2471bd10c0cc3713d4a4cdc23d6812f"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "02d87d06e67f104047cb1fe7ec4d1ed143a142bdcf0235a8080d9de5450b7d99" => :x86_64_linux
  end

  head do
    url "git://anongit.freedesktop.org/wayland/wayland-protocols"
  end

  option "without-test", "Skip compile-time tests"

  depends_on "linuxbrew/xorg/wayland" => :build
  depends_on "pkg-config" => :build

  if build.head?
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]

    system "autoreconf", "-fiv" if build.head?
    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
