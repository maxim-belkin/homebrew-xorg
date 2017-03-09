class Xmodmap < Formula
  desc "X.Org Applications: xmodmap"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xmodmap-1.0.9.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xmodmap-1.0.9.tar.bz2"
  sha256 "b7b0e5cc5f10d0fb6d2d6ea4f00c77e8ac0e847cc5a73be94cd86139ac4ac478"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "aa467c3ef7804c0609957eaf4cb636fd394d32c1efaf142774ea40b0339f9496" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libx11"

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
