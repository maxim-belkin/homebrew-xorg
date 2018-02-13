class Xf86bigfontproto < Formula
  desc "X.Org Protocol Headers: xf86bigfontproto"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/xf86bigfontproto-1.2.0.tar.bz2"
  sha256 "ba9220e2c4475f5ed2ddaa7287426b30089e4d29bd58d35fad57ba5ea43e1648"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "af0d2b1eedf5ed2a360b8c2b5dfa9d5eed671d178244e7a20fabb3f317cc437a" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]

    system "./configure", *args
    system "make", "install"
  end
end
