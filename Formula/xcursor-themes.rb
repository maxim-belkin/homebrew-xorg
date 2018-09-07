class XcursorThemes < Formula
  desc "X.Org: redglass and whiteglass animated cursor themes"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/archive/individual/data/xcursor-themes-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/data/xcursor-themes-1.0.4.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/data/xcursor-themes-1.0.4.tar.bz2"
  sha256 "e3fd2c05b9df0d88a3d1192c02143295744685f4f9a03db116e206698331bb86"
  revision 1
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "5191796c5ae5b8cb6d6e32be715fe4b839e7a060a3abbc6342314fc9c10c72c9" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/fixesproto" => :build
  depends_on "linuxbrew/xorg/kbproto" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" => :build
  depends_on "linuxbrew/xorg/renderproto" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xextproto" => :build
  depends_on "linuxbrew/xorg/libxcursor"
  depends_on "linuxbrew/xorg/xcursorgen"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-cursordir=#{share}/icons
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
