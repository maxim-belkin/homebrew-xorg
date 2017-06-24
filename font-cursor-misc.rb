class FontCursorMisc < Formula
  desc "X.Org Fonts: font cursor misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-cursor-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-cursor-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-cursor-misc-1.0.3.tar.bz2"
  sha256 "17363eb35eece2e08144da5f060c70103b59d0972b4f4d77fd84c9a7a2dba635"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "467daf5b42875a9ea59e6cac6920c9bf3a6218e728b3de1fb753fd4a0fab49e9" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/font-util" => :build
  depends_on "linuxbrew/xorg/bdftopcf" => :build
  depends_on "linuxbrew/xorg/mkfontdir" => :build
  depends_on "fontconfig" => :build
  depends_on "bzip2" => %i(build recommended)

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
