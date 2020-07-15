class Mtdev < Formula
  desc "Multitouch Protocol Translation Library"
  homepage "https://bitmath.org"
  url "https://bitmath.org/code/mtdev/mtdev-1.1.5.tar.bz2"
  sha256 "6677d5708a7948840de734d8b4675d5980d4561171c5a8e89e54adf7a13eba7f"
  # tag "linuxbrew"

  livecheck do
    url "https://bitmath.org/code/mtdev/"
    regex(/href=.*?mtdev[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "32778f8b518f949bd06e4ec20c3d9d0915febaedfb01011c7ab936076d88cd51" => :x86_64_linux
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
