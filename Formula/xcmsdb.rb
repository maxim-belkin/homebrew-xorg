class Xcmsdb < Formula
  desc "X.Org Applications: xcmsdb"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xcmsdb-1.0.6.tar.xz"
  mirror "https://ftp.x.org/pub/individual/app/xcmsdb-1.0.6.tar.xz"
  sha256 "3c77eec4537d5942bb0966973b787bfdaf7121f3125ffa81bb1c9708d4cf4f55"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d33cfabfbb30b55431202931add373ce7ccc4cf56b71173ddf9dae686fc987ac"
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
