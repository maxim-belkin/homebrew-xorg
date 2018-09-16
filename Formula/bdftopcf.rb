class Bdftopcf < Formula
  desc "X.Org Applications: bdftopcf"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/bdftopcf-1.1.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/bdftopcf-1.1.tar.bz2"
  sha256 "4b4df05fc53f1e98993638d6f7e178d95b31745c4568cee407e167491fd311a2"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "0189f9d16ceacee801ecf1f0ff438fabac5d1ff23ce021b6a7ca1039a25331a2" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/fontsproto" => :build
  depends_on "linuxbrew/xorg/util-macros"=> :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libxfont"
  depends_on "bzip2"

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
