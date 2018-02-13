class Compositeproto < Formula
  desc "X.Org Protocol Headers: compositeproto"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/compositeproto-0.4.2.tar.bz2"
  sha256 "049359f0be0b2b984a8149c966dd04e8c58e6eade2a4a309cf1126635ccd0cfc"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "4b1bf94e444d74a4acd8982fed297523b299373b72c775e98e008e7a9b5ba8c8" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build

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
