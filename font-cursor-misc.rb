# font-cursor-misc: Build a bottle for Linuxbrew
class FontCursorMisc < Formula
  desc "X.Org Fonts: font cursor misc"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-cursor-misc-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-cursor-misc-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-cursor-misc-1.0.3.tar.bz2"
  sha256 "17363eb35eece2e08144da5f060c70103b59d0972b4f4d77fd84c9a7a2dba635"
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

    prefix.install "README" => "font-cursor-misc.md"
  end
end
