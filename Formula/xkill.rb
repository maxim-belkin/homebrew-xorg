class Xkill < Formula
  desc "X.Org Applications: xkill"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkill-1.0.6.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xkill-1.0.6.tar.gz"
  sha256 "3b35a2f4b67dda1e98b6541488cd7f7343eb6e3dbe613aeff3d5a5a4c4c64b58"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "46ac34432421bc00623903c82ac48a3d195d6c338d173535778345f8ed9d8706"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libxmu" # brings in libx11

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
