class Xhost < Formula
  desc "X.Org Applications: xhost"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xhost-1.0.8.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xhost-1.0.8.tar.bz2"
  sha256 "a2dc3c579e13674947395ef8ccc1b3763f89012a216c2cc6277096489aadc396"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "44654e8fde19bf1d959066ee8377ba29513becfdfe330be5e12958adc0c6caba" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxmu"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-unix-transport
      --enable-tcp-transport
      --enable-ipv6
      --enable-local-transport
      --enable-secure-rpc
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
