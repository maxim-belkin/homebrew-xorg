class XcursorThemes < Formula
  desc "X.Org: redglass and whiteglass animated cursor themes"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/archive/individual/data/xcursor-themes-1.0.6.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/data/xcursor-themes-1.0.6.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/data/xcursor-themes-1.0.6.tar.bz2"
  sha256 "ee1ec574741293abcf66ac14ce7e74add7ac6be7deb8b38179ef010d22354999"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "aff195169736624a1f847c7689323a09d71e9ab9d491c8c88e449a78df6101dc" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xcursorgen" => :build
  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-cursordir=#{pkgshare}/icons
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
