class Xcmsdb < Formula
  desc "X.Org Applications: xcmsdb"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xcmsdb-1.0.5.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xcmsdb-1.0.5.tar.bz2"
  sha256 "e5585361bb8b6a05bb814a8d0e444ee93e0f00180881d3070aff4571e97f67c6"
  revision 1

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/xcmsdb-1.0.5_1"
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
