class Libxdamage < Formula
  desc "X.Org Libraries: libXdamage"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXdamage-1.1.5.tar.bz2"
  sha256 "b734068643cac3b5f3d2c8279dd366b5bf28c7219d9e9d8717e1383995e0ea45"
  # tag "linuxbrew"

  livecheck do
    url "https://ftp.x.org/archive/individual/lib/"
    regex(/libXdamage-([0-9.]+)\.tar.bz2/)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "d9c30c357ddba1b40626b060e1687f647c33bd2ea3add5a64d5fb22157553324" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxfixes"
  depends_on "linuxbrew/xorg/xorgproto"

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
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
