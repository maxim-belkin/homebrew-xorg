class Xwud < Formula
  desc "X.Org Applications: xwud"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwud-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xwud-1.0.4.tar.bz2"
  sha256 "d6b3a09ccfe750868e26bd2384900ab5ff0d434f7f40cd272a50eda8aaa1f8bd"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "daa425a235d783858b9d1e27ba1d6090105ad438714e0819afba9f011c43c55a" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
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
