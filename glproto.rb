class Glproto < Formula
  desc "X.Org Protocol Headers: glproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/glproto-1.4.17.tar.bz2"
  sha256 "adaa94bded310a2bfcbb9deb4d751d965fcfe6fb3a2f6d242e2df2d6589dbe40"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "ca1b0d27122bae1fd580bf9d46bfb7b925438c5e95ffb834c78bc9cb27d64904" => :x86_64_linux
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
