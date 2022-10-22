class Sessreg < Formula
  desc "X.Org Applications: sessreg"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/sessreg-1.1.2.tar.bz2"
  sha256 "dfcb9e954273ace63879aec053c7880466f8755752a35aa9ced3fa5f04fd2c33"

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build

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
