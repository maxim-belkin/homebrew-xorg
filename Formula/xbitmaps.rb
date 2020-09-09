class Xbitmaps < Formula
  desc "Bitmap images used by multiple applications"
  homepage "https://xcb.freedesktop.org"
  url "https://xorg.freedesktop.org/archive/individual/data/xbitmaps-1.1.2.tar.bz2"
  sha256 "b9f0c71563125937776c8f1f25174ae9685314cbd130fb4c2efce811981e07ee"

  bottle do
    cellar :any_skip_relocation
    sha256 "0bdbe7764069c18309ee18f7b8b9d5ad6b69e8ad49c7af376350f184dc7ecfac" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build

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
