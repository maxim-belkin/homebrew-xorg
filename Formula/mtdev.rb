class Mtdev < Formula
  desc "Multitouch Protocol Translation Library"
  homepage "https://bitmath.org"
  url "https://bitmath.org/code/mtdev/mtdev-1.1.6.tar.bz2"
  sha256 "15d7b28da8ac71d8bc8c9287c2045fd174267bc740bec10cfda332dc1204e0e0"

  livecheck do
    url "https://bitmath.org/code/mtdev/"
    regex(/href=.*?mtdev[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b79166172eee8100a20e0b4a704e44622bc06783db6c17ebaf5dcccce5ab759"
  end

  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    output = shell_output("ldd #{bin}/mtdev-test").chomp
    assert_match "lib/libmtdev.so.1", output
  end
end
