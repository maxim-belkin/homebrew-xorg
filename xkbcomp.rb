# xkbcomp: Build a bottle for Linuxbrew
class Xkbcomp < Formula
  desc "X.Org Applications: xkbcomp"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xkbcomp-1.3.1.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xkbcomp-1.3.1.tar.bz2"
  sha256 "0304dc9e0d4ac10831a9ef5d5419722375ddbc3eac3ff4413094d57bc1f1923d"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "libx11"
  depends_on "libxkbfile"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb-config-root=#{Formula["libx11"].share}/X11/xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
