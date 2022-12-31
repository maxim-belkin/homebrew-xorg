class Smproxy < Formula
  desc "X.Org Applications: smproxy"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/smproxy-1.0.7.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/smproxy-1.0.7.tar.gz"
  sha256 "aabd5e644512442da2bca1ce65ccee403b760a08e354b3474753ed36033e3d21"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c7c2a811fe38535c6e822ded7c80a669d8aa2a7616b144546cac60097bc836d6"
  end

  depends_on "pkg-config" => :build
  depends_on "libice"
  depends_on "libsm"
  depends_on "libx11"
  depends_on "libxmu"
  depends_on "libxt"

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
