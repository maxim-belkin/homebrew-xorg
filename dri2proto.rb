class Dri2proto < Formula
  desc "X.Org Protocol Headers: dri2proto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/dri2proto-2.8.tar.bz2"
  sha256 "f9b55476def44fc7c459b2537d17dbc731e36ed5d416af7ca0b1e2e676f8aa04"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "88361afd628af1a3efd25681666155629841f9174a1e376291770c56d658a802" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build

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
