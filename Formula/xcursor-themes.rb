class XcursorThemes < Formula
  desc "X.Org: redglass and whiteglass animated cursor themes"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/archive/individual/data/xcursor-themes-1.0.5.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/data/xcursor-themes-1.0.5.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/data/xcursor-themes-1.0.5.tar.bz2"
  sha256 "ae8381d39096598f7fe93fbd3ab079d93347a989f29e017f399ffcd20c8e1272"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "ccbd0177a9632e55bfdabe2aa78b64a0f22f5ffb51c373e8cfe9e2199cdd686c" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xcursorgen" => :build

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
