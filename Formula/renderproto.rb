class Renderproto < Formula
  desc "X.Org Protocol Headers: renderproto"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/renderproto-0.11.1.tar.bz2"
  sha256 "06735a5b92b20759204e4751ecd6064a2ad8a6246bb65b3078b862a00def2537"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "212f70f35f2826cf764f65c116f9a0a6182a460adac7389deb6e74ea8cd7f54d" => :x86_64_linux
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
