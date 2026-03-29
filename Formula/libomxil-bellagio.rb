class LibomxilBellagio < Formula
  desc "Mesa: cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://downloads.sourceforge.net/project/omxil/omxil/Bellagio%200.9.3/libomxil-bellagio-0.9.3.tar.gz"
  sha256 "593c0729c8ef8c1467b3bfefcf355ec19a46dd92e31bfc280e17d96b0934d74c"
  revision 1
  license "LGPL-2.1-or-later"

  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --enable-doc=no
    ]

    system "./configure", *args
    ENV.deparallelize
    system "make"
    system "make", "install"
  end
end
