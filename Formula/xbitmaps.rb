class Xbitmaps < Formula
  desc "Bitmap images used by multiple applications"
  homepage "https://xcb.freedesktop.org"
  url "https://xorg.freedesktop.org/archive/individual/data/xbitmaps-1.1.2.tar.bz2"
  sha256 "b9f0c71563125937776c8f1f25174ae9685314cbd130fb4c2efce811981e07ee"
  revision 1

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "8967e9c961afa04dfe212b05fd82b6a369388c7676b1993b72471b9a57eb9c35" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
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
