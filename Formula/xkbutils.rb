class Xkbutils < Formula
  desc "X.Org Applications: xkbutils"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbutils-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xkbutils-1.0.4.tar.bz2"
  sha256 "d2a18ab90275e8bca028773c44264d2266dab70853db4321bdbc18da75148130"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "f7eea4644fbd505790481fefab873d63b2771f7c1772558d0478090a5b0681f9" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxaw"
  depends_on "libxt"

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
