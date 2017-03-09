class Mkfontdir < Formula
  desc "X.Org Applications: mkfontdir"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/mkfontdir-1.0.7.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/mkfontdir-1.0.7.tar.bz2"
  sha256 "56d52a482df130484e51fd066d1b6eda7c2c02ddbc91fe6e2be1b9c4e7306530"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "b6e91d7d3264faea12876fd7aaceea3f32496298504438d83afeba812423ad10" => :x86_64_linux
  end

  depends_on "pkg-config"  => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/mkfontscale" => :run

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
