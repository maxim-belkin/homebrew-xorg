class LibvaUtils < Formula
  desc "Collection of utilities and examples to exercise VA-API"
  homepage "https://github.com/01org/libva-utils"
  url "https://github.com/intel/libva-utils/releases/download/2.6.0/libva-utils-2.6.0.tar.bz2"
  sha256 "2249b5d08bffc3862bbdcc9a6a4827afd504330b8d101564d39fe1a1e7adc426"

  bottle do
    cellar :any_skip_relocation
    sha256 "c28d91e8882bd101a42915eaa9e91225fe5892f54d0bab4d77af0f28516aeb57" => :x86_64_linux
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
