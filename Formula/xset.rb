class Xset < Formula
  desc "X.Org Applications: xset"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xset-1.2.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xset-1.2.4.tar.bz2"
  sha256 "e4fd95280df52a88e9b0abc1fee11dcf0f34fc24041b9f45a247e52df941c957"
  # tag "linuxbrew"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/libxmu"
  depends_on "linuxbrew/xorg/libxfontcache" # brings in dep on libxext and libx11
  depends_on "linuxbrew/xorg/libxxf86misc"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    #   --without-xf86misc      Disable xf86misc support.
    #   --without-fontcache     Disable fontcache support

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
