class Xcursorgen < Formula
  desc "X.Org Applications: xcursorgen"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xcursorgen-1.0.7.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xcursorgen-1.0.7.tar.bz2"
  sha256 "35b6f844b24f1776e9006c880a745728800764dbe3b327a128772b4610d8eb3d"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "5eb5cc0e64c2c05bf5c8f626e0aa8f796bf8d1a572d1d6bff9916f6bae6a1510" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "libpng"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxcursor"

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
