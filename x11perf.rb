class X11perf < Formula
  desc "X.Org Applications: x11perf"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/x11perf-1.6.0.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/x11perf-1.6.0.tar.bz2"
  sha256 "e87098dec1947572d70c62697a7b70bde1ab5668237d4660080eade6bc096751"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "44fd4be54b3c9608490dea106d2ad134d6de072135e9d6b602848e2a2b5553c6" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxmu"
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libxrender" # crucial
  depends_on "linuxbrew/xorg/libxft" # not crucial

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
