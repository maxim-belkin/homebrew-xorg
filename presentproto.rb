# presentproto: Build a bottle for Linuxbrew
class Presentproto < Formula
  desc "X.Org Protocol Headers: presentproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/presentproto-1.0.tar.bz2"
  sha256 "812c7d48721f909a0f7a2cb1e91f6eead76159a36c4712f4579ca587552839ce"
  # tag "linuxbrew"

  depends_on "pkg-config"         =>  :build
  depends_on "util-macros"        =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end
end
