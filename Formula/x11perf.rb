class X11perf < Formula
  desc "X.Org Applications: x11perf"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/x11perf-1.6.1.tar.bz2"
  sha256 "1c7e0b8ffc2794b4ccf11e04d551823abe0ea47b4f7db0637390db6fbe817c34"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "44fd4be54b3c9608490dea106d2ad134d6de072135e9d6b602848e2a2b5553c6" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxft" # not critical
  depends_on "linuxbrew/xorg/libxmu"
  depends_on "linuxbrew/xorg/libxrender" # critical

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
