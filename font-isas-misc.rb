class FontIsasMisc < Formula
  desc "X.Org Fonts: font isas misc"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-isas-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-isas-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-isas-misc-1.0.3.tar.bz2"
  sha256 "5824ab4b485951107dd245b8f7717d2822f1a6dbf6cea98f1ac7f49905c0a867"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "de25e41ac6c7efeef6acd0169d35b1a8ca688d684ca5ac4daa58ac21b3392bdc" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/font-util"  =>  :build
  depends_on "linuxbrew/xorg/bdftopcf"   =>  :build
  depends_on "linuxbrew/xorg/mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build
  depends_on "bzip2"      => [:build, :recommended]

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]
    args << "--with-compression=bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
