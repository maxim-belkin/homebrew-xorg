class FontMicroMisc < Formula
  desc "X.Org Fonts: font micro misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-micro-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-micro-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-micro-misc-1.0.3.tar.bz2"
  sha256 "9a3381c10f32d9511f0ad4179df395914c50779103c16cddf7017f5220ed8db6"
  revision 2
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "8d8180148f8e5afc60c4acb48bad85e0c179a9af3bae1484f4bbff2aa72aff6f" => :x86_64_linux
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
