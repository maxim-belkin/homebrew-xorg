class Xvinfo < Formula
  desc "X.Org Applications: xvinfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xvinfo-1.1.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xvinfo-1.1.4.tar.bz2"
  sha256 "0353220d6606077ba42363db65f50410759f9815352f77adc799e2adfa76e73f"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "500a1d2d594d056a6b4b23d43278a6eeaff7a5c9c7c7c62f9ae487c3c3ed84e9" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxv"

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
