class Xev < Formula
  desc "X.Org Applications: xev"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xev-1.2.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xev-1.2.2.tar.bz2"
  sha256 "d94ae62a6c1af56c2961d71f5782076ac4116f0fa4e401420ac7e0db33dc314f"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "797f3a6ae4c84b37a60f3c2e9c1eca9128b5e9defc50209ac97dac48f4b587c1" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libxrandr"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/xproto" => :build

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
