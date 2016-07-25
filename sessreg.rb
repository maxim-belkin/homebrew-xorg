# sessreg: Build a bottle for Linuxbrew
class Sessreg < Formula
  desc "X.Org Applications: sessreg"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/sessreg-1.1.0.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/sessreg-1.1.0.tar.bz2"
  sha256 "551177657835e0902b5eee7b19713035beaa1581bbd3c6506baa553e751e017c"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "xproto"     =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    inreplace "man/Makefile.in", '$(CPP) $(DEFS)', '$(CPP) -P $(DEFS)'

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
