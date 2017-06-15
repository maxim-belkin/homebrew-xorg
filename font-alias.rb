class FontAlias < Formula
  desc "X.Org Fonts: font alias"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-alias-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-alias-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-alias-1.0.3.tar.bz2"
  sha256 "8b453b2aae1cfa8090009ca037037b8c5e333550651d5a158b7264ce1d472c9a"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "1486363066ac2288cb10218c7fd9b1672f56e42e79f5853df122068bef063db8" => :x86_64_linux
  end

  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
