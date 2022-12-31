class FontAlias < Formula
  desc "X.Org Fonts: font alias"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-alias-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-alias-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-alias-1.0.4.tar.bz2"
  sha256 "f3111ae8bf2e980f5f56af400e8eefe5fc9f4207f4a412ea79637fd66c945276"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "576c970209959d022e064a72baabb5808914867926a96f31fc12561dffe05942"
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
