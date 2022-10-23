class Xcursorgen < Formula
  desc "X.Org Applications: xcursorgen"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xcursorgen-1.0.7.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xcursorgen-1.0.7.tar.bz2"
  sha256 "35b6f844b24f1776e9006c880a745728800764dbe3b327a128772b4610d8eb3d"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "93a0614cc8c8542e2bfe7aacf101de393c9e9cf040bbd905b61e82c48c448c89"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xorgproto" => :build
  depends_on "libpng"
  depends_on "libx11"
  depends_on "libxcursor"

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
