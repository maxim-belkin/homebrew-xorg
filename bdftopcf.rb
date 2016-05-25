# bdftopcf: Build a bottle for Linuxbrew
class Bdftopcf < Formula
  desc "X.Org Applications: bdftopcf"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/bdftopcf-1.0.5.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/bdftopcf-1.0.5.tar.bz2"
  sha256 "38f447be0c61f94c473f128cf519dd0cff63b5d7775240a2e895a183a61e2026"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "libxfont"
  depends_on "bzip2"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
