class XorgSgmlDoctools < Formula
  desc "X.Org SGML DocTools"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/doc/xorg-sgml-doctools-1.11.tar.gz"
  sha256 "986326d7b4dd2ad298f61d8d41fe3929ac6191c6000d6d7e47a8ffc0c34e7426"
  revision 1

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/xorg-sgml-doctools-1.11_1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0565182114010a16c12ea163f76b4abfd7e120abd9283b27b32e2be7c568e01c"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros"=> :build

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
