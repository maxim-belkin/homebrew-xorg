class Xdriinfo < Formula
  desc "X.Org Applications: xdriinfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xdriinfo-1.0.7.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xdriinfo-1.0.7.tar.gz"
  sha256 "9fab95510b1f67409632fb8af01369b128f4d12763fe1a2662f5666976a7d30c"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6d2c43ab1bbe11e3f6110e8eaf7b5b95cc8119b2a0de5186c55c2758605af0f5"
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
