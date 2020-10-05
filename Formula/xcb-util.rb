class XcbUtil < Formula
  desc "Additional extensions to the XCB library"
  homepage "https://xcb.freedesktop.org"
  url "https://xcb.freedesktop.org/dist/xcb-util-0.4.0.tar.bz2"
  sha256 "46e49469cb3b594af1d33176cd7565def2be3fa8be4371d62271fabb5eae50e9"
  revision 1

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "11fc8a7905dafedeacb33855e484a80997bac1cb8d6f0191ebfe12060e41510f" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "libxcb"

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
end
