class Xf86vidmodeproto < Formula
  desc "X.Org Protocol Headers: xf86vidmodeproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/xf86vidmodeproto-2.3.1.tar.bz2"
  sha256 "45d9499aa7b73203fd6b3505b0259624afed5c16b941bd04fcf123e5de698770"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "fcf020ee7ae77f134702e0ae849e7d4211e7db404431ef0a02e6076c66e753cd" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end
end
