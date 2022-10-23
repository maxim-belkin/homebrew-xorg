class Xgamma < Formula
  desc "X.Org Applications: xgamma"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xgamma-1.0.6.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xgamma-1.0.6.tar.bz2"
  sha256 "0ef1c35b5c18b1b22317f455c8df13c0a471a8efad63c89c98ae3ce8c2b222d3"
  revision 1

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
