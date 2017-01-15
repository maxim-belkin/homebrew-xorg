class Xineramaproto < Formula
  desc "X.Org Protocol Headers: xineramaproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/xineramaproto-1.2.1.tar.bz2"
  sha256 "977574bb3dc192ecd9c55f59f991ec1dff340be3e31392c95deff423da52485b"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "42b4c1562aa8cfa5fc8ed49a2226bac13eb01c1b25d00e147870b342dea99ff2" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end
end
