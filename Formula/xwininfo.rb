class Xwininfo < Formula
  desc "X.Org Applications: xwininfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwininfo-1.1.5.tar.bz2"
  sha256 "7a405441dfc476666c744f5fcd1bc8a75abf8b5b1d85db7b88b370982365080e"
  revision 2

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/xwininfo-1.1.5_2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "40a443508592c5a0993b2c089ed2bc55675dc1b55edc05a50408bf0385d44492"
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "xcb-util-wm"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xcb-icccm
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
