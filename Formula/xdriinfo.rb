class Xdriinfo < Formula
  desc "X.Org Applications: xdriinfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xdriinfo-1.0.6.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xdriinfo-1.0.6.tar.bz2"
  sha256 "d9ccd2c3e87899417acc9ea1f3e319a4198112babe1dc711273584f607449d51"
  revision 2

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/xdriinfo-1.0.6_2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "92b47c8ba8e32bc9fbfd27be6a355ebe7d5872a04028150bc79ad7e353db21ba"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "mesa"

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
