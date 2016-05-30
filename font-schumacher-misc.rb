# font-schumacher-misc: Build a bottle for Linuxbrew
class FontSchumacherMisc < Formula
  desc "X.Org Fonts: font schumacher misc"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-schumacher-misc-1.1.2.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-schumacher-misc-1.1.2.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-schumacher-misc-1.1.2.tar.bz2"
  sha256 "e444028656e0767e2eddc6d9aca462b16a2be75a47244dbc199b2c44eca87e5a"
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

    prefix.install "README" => "font-schumacher-misc.md"
  end
end
