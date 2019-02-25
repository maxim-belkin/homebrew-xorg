class LibvaUtils < Formula
  desc "Collection of utilities and examples to exercise VA-API"
  homepage "https://github.com/01org/libva-utils"
  url "https://github.com/intel/libva-utils/releases/download/2.4.0/libva-utils-2.4.0.tar.bz2"
  sha256 "5b7d1954b40fcb2c0544be20125c71a0852049715ab85a3e8aba60434a40c6b3"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "9d3fc7fcc80bbf8500784125f9ab009c1935e46f921b55932fb42aab046b3497" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libva"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/wayland"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-drm
      --enable-x11
      --enable-wayland
      --enable-tests=yes
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
