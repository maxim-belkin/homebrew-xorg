class XorgSgmlDoctools < Formula
  desc "X.Org SGML DocTools"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/doc/xorg-sgml-doctools-1.12.tar.gz"
  sha256 "985a0329e6a6dadd6ad517f8d54f8766ab4b52bb8da7b07d02ec466bec444bdb"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
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
