class Xdpyinfo < Formula
  desc "X.Org Applications: xdpyinfo"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xdpyinfo-1.3.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xdpyinfo-1.3.2.tar.bz2"
  sha256 "30238ed915619e06ceb41721e5f747d67320555cc38d459e954839c189ccaf51"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "5ad449cbcce936b2d12f06b938626c06782f38bce097b6121d639d4df14364b7" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxtst"
  depends_on "linuxbrew/xorg/libxcb"
  depends_on "linuxbrew/xorg/xproto" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
      #  --without-dga           Disable dga support.
      #  --without-xf86misc      Disable xf86misc support.
      #  --without-xinerama      Disable xinerama support.
      #  --without-dmx           Disable dmx support.

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
