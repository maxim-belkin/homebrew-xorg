# xrdb: Build a bottle for Linuxbrew
class Xrdb < Formula
  desc "X.Org Applications: xrdb"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xrdb-1.1.0.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xrdb-1.1.0.tar.bz2"
  sha256 "73827b6bbfc9d27ca287d95a1224c306d7053cd7b8156641698d7dc541ca565b"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "xproto" => :build
  depends_on "libx11"
  depends_on "libxmu"

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
