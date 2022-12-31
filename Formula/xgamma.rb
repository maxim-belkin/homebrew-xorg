class Xgamma < Formula
  desc "X.Org Applications: xgamma"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xgamma-1.0.7.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xgamma-1.0.7.tar.gz"
  sha256 "61f5ef02883d65ab464678ad3d8c5445a0ff727fe6255af90b1b842ddf77370d"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "84071f66535c5ae388c1c7b3a975014d3bf4d449dc62beca39ab1ebaef671436"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxxf86vm"

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
