class Sessreg < Formula
  desc "X.Org Applications: sessreg"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/sessreg-1.1.0.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/sessreg-1.1.0.tar.bz2"
  sha256 "551177657835e0902b5eee7b19713035beaa1581bbd3c6506baa553e751e017c"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "17242c86ba919ff7bc10828ef3700ed097cb661508918c1bf8d0c75c748584df" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xproto" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    inreplace "man/Makefile.in", "$(CPP) $(DEFS)", "$(CPP) -P $(DEFS)"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
