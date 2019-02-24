class Xmodmap < Formula
  desc "X.Org Applications: xmodmap"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xmodmap-1.0.10.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xmodmap-1.0.10.tar.bz2"
  sha256 "473f0941d7439d501bb895ff358832b936ec34c749b9704c37a15e11c318487c"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "aa467c3ef7804c0609957eaf4cb636fd394d32c1efaf142774ea40b0339f9496" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
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
