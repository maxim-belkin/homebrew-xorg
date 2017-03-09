class Xrdb < Formula
  desc "X.Org Applications: xrdb"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xrdb-1.1.0.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xrdb-1.1.0.tar.bz2"
  sha256 "73827b6bbfc9d27ca287d95a1224c306d7053cd7b8156641698d7dc541ca565b"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "1cb029caf85881e385b1282c82ddbb4fc982998ed480221990f23e96b2b62820" => :x86_64_linux
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
    # --with-cpp=path  # comma-separated list of paths to cpp command for xrdb to use at runtime

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
