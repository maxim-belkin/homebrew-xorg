class Xhost < Formula
  desc "X server access control tool"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xhost-1.0.9.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xhost-1.0.9.tar.gz"
  sha256 "ca850367593fcddc4bff16de7ea1598aa4f6817daf5a803a1258dff5e337f7c3"

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
    assert_match(/access control (enabled|disabled)/, shell_output("xhost"))
  end
end
