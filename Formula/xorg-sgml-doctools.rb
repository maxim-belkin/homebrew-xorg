class XorgSgmlDoctools < Formula
  desc "X.Org SGML DocTools"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/doc/xorg-sgml-doctools-1.12.1.tar.gz"
  sha256 "8de3406f96a02bc3ab51ff47ba1612d9a11fc25d2edcaa06caa2cb2420d7bae0"
  license "MIT"

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

  test do
    assert_predicate share/"sgml/X11", :directory?
  end
end
