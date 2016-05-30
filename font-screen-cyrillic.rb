# font-screen-cyrillic: Build a bottle for Linuxbrew
class FontScreenCyrillic < Formula
  desc "X.Org Fonts: font screen cyrillic"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-screen-cyrillic-1.0.4.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-screen-cyrillic-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-screen-cyrillic-1.0.4.tar.bz2"
  sha256 "824231e8dffe15299454e47259f29d98001c9cf8ad3d6b5171399e4d71705e79"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "font-util"  =>  :build
  depends_on "bdftopcf"   =>  :build
  depends_on "mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build
  depends_on "bzip2"      => [:build, :recommended]

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--with-compression=bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"

    prefix.install "README" => "font-screen-cyrillic.md"
  end
end
