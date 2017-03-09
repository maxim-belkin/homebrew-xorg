class Xvinfo < Formula
  desc "X.Org Applications: xvinfo"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xvinfo-1.1.3.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xvinfo-1.1.3.tar.bz2"
  sha256 "9fba8b68daf53863e66d5004fa9c703fcecf69db4d151ea2d3d885d621e6e5eb"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "500a1d2d594d056a6b4b23d43278a6eeaff7a5c9c7c7c62f9ae487c3c3ed84e9" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxv"

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
