class Xkeyboardconfig < Formula
  desc "Keyboard configuration database for the X Window System"
  homepage "https://xorg.freedesktop.org"
  url "https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-2.17.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.17.tar.bz2"
  sha256 "dec6be44bd31775cdc1ab95bfd75d5f2c0055613eeca8b4e9c6480b183430701"

  bottle do
    cellar :any_skip_relocation
    sha256 "9487e7667e83f7fb041c35eb8fca4bbfd4c290eadf1c7f514fa57c662171e8b0" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xorg" => :build
  depends_on "intltool" => :build

  def install
    # Standard XORG_CONFIG flags
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--with-xkb-rules-symlink=xorg"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
