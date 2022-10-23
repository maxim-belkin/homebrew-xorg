class Xkill < Formula
  desc "X.Org Applications: xkill"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkill-1.0.5.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xkill-1.0.5.tar.bz2"
  sha256 "c5f0bb6a95e1ac7c4def8a657496d5d2f21ccd41eb47ef2c9ccb03fb6d6aff6b"
  revision 1

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/xkill-1.0.5_1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "46692b5338539999a985895ef2ced0becdd35a99fa704158d6aa29f3a6659a09"
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
