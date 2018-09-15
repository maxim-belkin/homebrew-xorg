class Mkfontscale < Formula
  desc "X.Org Applications: mkfontscale"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/mkfontscale-1.1.3.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/mkfontscale-1.1.3.tar.bz2"
  sha256 "1e98df69ee5f4542d711e140e1d93e2c3f2775407ccbb7849110d52b91782a6a"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "fc801288a76cdad16eabb8301291be740a9e5deac05a906b4485301e73c590a6" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libfontenc"
  depends_on "freetype"
  depends_on "bzip2" => :recommended

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-bzip2=#{build.with?("bzip2") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
