class Xbacklight < Formula
  desc "X.Org Applications: xbacklight"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xbacklight-1.2.1.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xbacklight-1.2.1.tar.bz2"
  sha256 "17f6cf51a35eaa918abec36b7871d28b712c169312e22a0eaf1ffe8d6468362b"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "3d5616b0ea4f03261672a861e577bee86cb731a956af45f64e40b95d1b53ad68" => :x86_64_linux
  end

  # xcb-randr >= 1.2 xcb-atom xcb-aux xcb
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libxcb"
  depends_on "linuxbrew/xorg/xcb-util"
  depends_on "linuxbrew/xorg/xcb-util-image"

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
