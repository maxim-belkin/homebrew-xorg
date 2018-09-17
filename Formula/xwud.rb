class Xwud < Formula
  desc "X.Org Applications: xwud"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwud-1.0.5.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xwud-1.0.5.tar.bz2"
  sha256 "99997051f8a892313f22edf41dab45864e86e7062ee9012d5dbb6a40fc6b10a9"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "daa425a235d783858b9d1e27ba1d6090105ad438714e0819afba9f011c43c55a" => :x86_64_linux
  end

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
