class Wayland < Formula
  desc "Protocol for a compositor to talk to its clients"
  homepage "https://wayland.freedesktop.org"
  url "https://wayland.freedesktop.org/releases/wayland-1.18.0.tar.xz"
  sha256 "4675a79f091020817a98fd0484e7208c8762242266967f55a67776936c2e294d"
  revision 1

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "d3bfcf08a75e5af6c9040577eb4a62e7cb9026446f1016166695bb1371a82e12" => :x86_64_linux
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
