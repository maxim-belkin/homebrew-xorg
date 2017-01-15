class Damageproto < Formula
  desc "X.Org Protocol Headers: damageproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/damageproto-1.2.1.tar.bz2"
  sha256 "5c7c112e9b9ea8a9d5b019e5f17d481ae20f766cb7a4648360e7c1b46fc9fc5b"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "97bf4f9ad52aefdcdb9169c0a436c38d12e1db32db65b234073e04d06a3f02bd" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

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
