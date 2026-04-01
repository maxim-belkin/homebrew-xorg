class Xhost < Formula
  desc "X server access control tool"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xhost-1.0.10.tar.gz"
  sha256 "10a157a9c818e6ec17764ba22117e006089107a22aacf58be6de089a76a112f4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "48b30768a0bff20fc560c0478794f13e55ed1890532582886848f997e3105ff4"
  end

  depends_on "gettext" => :build
  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxmu"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-unix-transport
      --enable-tcp-transport
      --enable-ipv6
      --enable-local-transport
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_match(/access control (enabled|disabled)/, shell_output("#{bin}/xhost"))
  end
end
