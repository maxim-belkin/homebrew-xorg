class Xdriinfo < Formula
  desc "X.Org Applications: xdriinfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xdriinfo-1.0.6.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xdriinfo-1.0.6.tar.bz2"
  sha256 "d9ccd2c3e87899417acc9ea1f3e319a4198112babe1dc711273584f607449d51"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "d2a11d9cb644ccd419b865e5deabdc0e8250d101a2656311accd0233ba82084e" => :x86_64_linux
  end

  # tag "linuxbrew"

  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
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
