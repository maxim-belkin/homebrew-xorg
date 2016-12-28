class Xbitmaps < Formula
  desc "Bitmap images used by multiple applications"
  homepage "http://xcb.freedesktop.org"
  url "https://xorg.freedesktop.org/archive/individual/data/xbitmaps-1.1.1.tar.bz2"
  sha256 "3671b034356bbc4d32d052808cf646c940ec8b2d1913adac51b1453e41aa1e9d"

  bottle do
    cellar :any
    sha256 "fb234ad593ff26c68e520b1c33ad27c6668b2cd1c6a569c08f9e6608ce74d9b1" => :x86_64_linux
  end

  depends_on "pkg-config"  => :build
  depends_on "util-macros" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end
end
