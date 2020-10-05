class Xcursorgen < Formula
  desc "X.Org Applications: xcursorgen"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xcursorgen-1.0.7.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xcursorgen-1.0.7.tar.bz2"
  sha256 "35b6f844b24f1776e9006c880a745728800764dbe3b327a128772b4610d8eb3d"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "01ed4b194da50aadaeb52a4778ecf1035ecb04ac40fc8d4db891f75f04635d13" => :x86_64_linux
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
