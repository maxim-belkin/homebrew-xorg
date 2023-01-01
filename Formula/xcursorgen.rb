class Xcursorgen < Formula
  desc "X.Org Applications: xcursorgen"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xcursorgen-1.0.8.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xcursorgen-1.0.8.tar.gz"
  sha256 "b8bb2756918343b8bc15a4ce875e9efb6c4e7777adba088280e53dd09753b6ac"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e012d2c68a06ab5ec6f5020bd7dfbb0eb599617373c5d8ff6e5f69cb41328bf2"
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
