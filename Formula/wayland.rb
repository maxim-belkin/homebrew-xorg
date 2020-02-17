class Wayland < Formula
  desc "Protocol for a compositor to talk to its clients"
  homepage "https://wayland.freedesktop.org"
  url "https://wayland.freedesktop.org/releases/wayland-1.18.0.tar.xz"
  sha256 "4675a79f091020817a98fd0484e7208c8762242266967f55a67776936c2e294d"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "5099ecb746c4c26155d9cc4cecfa747ada11af8d2a7406822ded9b7b5fc5d3c4" => :x86_64_linux
  end

  head do
    url "git://anongit.freedesktop.org/wayland/wayland"
  end

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
    ]

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end
    system "make"
    ENV.deparallelize
    system "make", "install"
  end
end
