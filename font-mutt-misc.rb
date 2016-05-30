# font-mutt-misc: Build a bottle for Linuxbrew
class FontMuttMisc < Formula
  desc "X.Org Fonts: font mutt misc"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-mutt-misc-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-mutt-misc-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-mutt-misc-1.0.3.tar.bz2"
  sha256 "bd5f7adb34367c197773a9801df5bce7b019664941900b2a31fbfe1ff2830f8f"
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

    prefix.install "README" => "font-mutt-misc.md"
  end
end
