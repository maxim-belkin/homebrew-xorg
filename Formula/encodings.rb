class Encodings < Formula
  desc "X.Org Fonts: encodings"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/encodings-1.1.0.tar.gz"
  sha256 "7d9b7afedc97c3b29b6262b3346728b877f0a91a4a5802bf091df4cffb43a568"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "23f84779e8dd2ce23e873fbe2be45f3b47c53a1eb30c45cf6c8291537170d91a"
  end

  keg_only "part of Xorg-fonts package"

  depends_on "font-util" => :build
  depends_on "mkfontscale" => :build
  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_predicate share/"fonts/X11", :directory?
  end
end
