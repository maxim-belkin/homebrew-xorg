class Xpr < Formula
  desc "X.Org Applications: xpr"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xpr-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xpr-1.0.4.tar.bz2"
  sha256 "fed98df31eb93d3dca4688cb535aabad06be572e70ace3b1685679c18dd86cb5"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "16e431229c4449d346f353b3776293362d252a90f52d6815feefbff7ac28d748" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxmu"

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
