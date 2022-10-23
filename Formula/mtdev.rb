class Mtdev < Formula
  desc "Multitouch Protocol Translation Library"
  homepage "https://bitmath.org"
  url "https://bitmath.org/code/mtdev/mtdev-1.1.5.tar.bz2"
  sha256 "6677d5708a7948840de734d8b4675d5980d4561171c5a8e89e54adf7a13eba7f"

  livecheck do
    url "https://bitmath.org/code/mtdev/"
    regex(/href=.*?mtdev[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec9d690f978f0974f2d01c23117add4a73804bc646ec5ea78bc39d8ac99cc039"
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
