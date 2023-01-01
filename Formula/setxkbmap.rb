class Setxkbmap < Formula
  desc "X.Org Applications: setxkbmap"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/setxkbmap-1.3.3.tar.gz"
  sha256 "51ba28edf93a464a7444b53b154fd5e93dedd1e9bbcc85b636f4cf56986c4842"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "71ce7fcba9efccead7d9e3777eb9b8b4e4f448c8bb01bf6a750d92179cf1b476"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libx11"
  depends_on "libxkbfile"
  depends_on "xrandr"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb-config-root=#{Formula["libx11"].share}/X11/xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
