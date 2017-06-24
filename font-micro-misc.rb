class FontMicroMisc < Formula
  desc "X.Org Fonts: font micro misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-micro-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-micro-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-micro-misc-1.0.3.tar.bz2"
  sha256 "9a3381c10f32d9511f0ad4179df395914c50779103c16cddf7017f5220ed8db6"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "6ed219758dbdd467c430fcd746bf1c4380144fd605710a14032c284ad247d169" => :x86_64_linux
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
