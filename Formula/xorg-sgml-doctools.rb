class XorgSgmlDoctools < Formula
  desc "X.Org SGML DocTools"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/doc/xorg-sgml-doctools-1.12.tar.gz"
  sha256 "985a0329e6a6dadd6ad517f8d54f8766ab4b52bb8da7b07d02ec466bec444bdb"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ab49e295c61e8fba0188e6b42dd35494363e9b81f834d75e669da9eb93a491e8"
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
