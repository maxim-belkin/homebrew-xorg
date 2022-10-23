class Xev < Formula
  desc "X.Org Applications: xev"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xev-1.2.3.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xev-1.2.3.tar.bz2"
  sha256 "66bc4f1cfa1946d62612737815c34164e4ce40fcebd2c9e1d7e7a1117ad3ad09"
  revision 2

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/xev-1.2.3_2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "829dfdda2ec6a0b8256d68f00aa730f45052364a8c989c4641e77e7e59fb8e0e"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxrandr"

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
