class Encodings < Formula
  desc "X.Org Fonts: encodings"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/encodings-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/encodings-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/encodings-1.0.4.tar.bz2"
  sha256 "ced6312988a45d23812c2ac708b4595f63fd7a49c4dcd9f66bdcd50d1057d539"
  revision 1
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "80e9c0aea351de9f225610fb98692d95b6cdaa4d0800592b96cb9bfa5ebe5449" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/font-util" => :build
  depends_on "linuxbrew/xorg/mkfontscale" => :build

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

  # def post_install
  #   (Formula["font-util"].share/"fonts/X11/encodings").install_symlink Dir[share/"fonts/X11/encodings/*"].select { |f| "fonts.dir" != f }
  # end
end
