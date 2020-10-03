class FontIsasMisc < Formula
  desc "X.Org Fonts: font isas misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-isas-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-isas-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-isas-misc-1.0.3.tar.bz2"
  sha256 "5824ab4b485951107dd245b8f7717d2822f1a6dbf6cea98f1ac7f49905c0a867"
  revision 2
  # tag "linuxbrew"

  bottle do
  end

  keg_only "part of Xorg-fonts package"

  depends_on "bzip2" => [:build, :recommended]
  depends_on "font-util" => :build
  depends_on "fontconfig" => :build
  depends_on "linuxbrew/xorg/bdftopcf" => :build
  depends_on "linuxbrew/xorg/mkfontscale" => :build
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
    args << "--with-compression=bzip2" if build.with? "bzip2"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
