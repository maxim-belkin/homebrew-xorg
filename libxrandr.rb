class Libxrandr < Formula
  desc "Xorg Libraries: libXrandr"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXrandr-1.5.0.tar.bz2"
  sha256 "6f864959b7fc35db11754b270d71106ef5b5cf363426aa58589cb8ac8266de58"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries"

  depends_on "pkg-config" =>  :build
  depends_on "fontconfig" =>  :build

  depends_on "libxrender" =>  :build
  depends_on "libx11"
  depends_on "randrproto" =>  :build
  depends_on "libxext"
  depends_on "xextproto"  =>  :build
  depends_on "libxrender"
  depends_on "renderproto" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--disable-static" if !build.with?("static")

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("check")
    system "make", "install"
  end
end
