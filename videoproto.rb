# videoproto: Build a bottle for Linuxbrew
class Videoproto < Formula
  desc "X.Org Protocol Headers: videoproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/videoproto-2.3.3.tar.bz2"
  sha256 "c7803889fd08e6fcaf7b68cc394fb038b2325d1f315e571a6954577e07cca702"
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
