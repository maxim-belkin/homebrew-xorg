class Fixesproto < Formula
  desc "X.Org Protocol Headers: fixesproto"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/fixesproto-5.0.tar.bz2"
  sha256 "ba2f3f31246bdd3f2a0acf8bd3b09ba99cab965c7fb2c2c92b7dc72870e424ce"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "dcfed30e21197c8d4c9384e9d1e5304c49983d4866f0186ebe2fdf06e80a4801" => :x86_64_linux
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
