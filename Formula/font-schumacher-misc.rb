class FontSchumacherMisc < Formula
  desc "X.Org Fonts: font schumacher misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-schumacher-misc-1.1.2.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-schumacher-misc-1.1.2.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-schumacher-misc-1.1.2.tar.bz2"
  sha256 "e444028656e0767e2eddc6d9aca462b16a2be75a47244dbc199b2c44eca87e5a"
  revision 2
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "02904e3a0c4e70b0c59543aba1b476f56ea04dc7b8b5119b83f6f94725395f41" => :x86_64_linux
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
