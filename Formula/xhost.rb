class Xhost < Formula
  desc "X server access control tool"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xhost-1.0.8.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xhost-1.0.8.tar.bz2"
  sha256 "a2dc3c579e13674947395ef8ccc1b3763f89012a216c2cc6277096489aadc396"
  revision 1

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
