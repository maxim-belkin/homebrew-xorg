class Xgamma < Formula
  desc "X.Org Applications: xgamma"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xgamma-1.0.6.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xgamma-1.0.6.tar.bz2"
  sha256 "0ef1c35b5c18b1b22317f455c8df13c0a471a8efad63c89c98ae3ce8c2b222d3"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "87fabdb6407145ed9e5e2329b8f3049188f07c42e3e5d52df2c964f7eac68161" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxxf86vm"
  depends_on "linuxbrew/xorg/xproto" => :build

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
