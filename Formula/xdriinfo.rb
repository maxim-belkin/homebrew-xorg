class Xdriinfo < Formula
  desc "X.Org Applications: xdriinfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xdriinfo-1.0.7.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xdriinfo-1.0.7.tar.gz"
  sha256 "9fab95510b1f67409632fb8af01369b128f4d12763fe1a2662f5666976a7d30c"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "92b47c8ba8e32bc9fbfd27be6a355ebe7d5872a04028150bc79ad7e353db21ba"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "mesa"

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
