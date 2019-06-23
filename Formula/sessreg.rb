class Sessreg < Formula
  desc "X.Org Applications: sessreg"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/sessreg-1.1.2.tar.bz2"
  sha256 "dfcb9e954273ace63879aec053c7880466f8755752a35aa9ced3fa5f04fd2c33"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "d9e91c3d473f2a27b0eb04be0e713c813f2ae375f36ee5e9f63674db36b09e8b" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build

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
