class Xcmsdb < Formula
  desc "X.Org Applications: xcmsdb"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xcmsdb-1.0.6.tar.xz"
  mirror "https://ftp.x.org/pub/individual/app/xcmsdb-1.0.6.tar.xz"
  sha256 "3c77eec4537d5942bb0966973b787bfdaf7121f3125ffa81bb1c9708d4cf4f55"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "efe3110bdd395b06c14ad9cee3b0202a1efa62138f4b9c06cb2372ef32322fb4"
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"

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
