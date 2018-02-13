class Resourceproto < Formula
  desc "X.Org Protocol Headers: resourceproto"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/resourceproto-1.2.0.tar.bz2"
  sha256 "3c66003a6bdeb0f70932a9ed3cf57cc554234154378d301e0c5cfa189d8f6818"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "86232aafd92fda6c30e16b16cf03b17df6178495d13ce31baf47f4ec381e2630" => :x86_64_linux
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
