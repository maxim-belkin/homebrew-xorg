class Encodings < Formula
  desc "X.Org Fonts: encodings"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/encodings-1.0.6.tar.gz"
  sha256 "c89c0636cda8f34eb28304263fc9a5441635ac3cb9da23efefe8f584174cba29"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ca5f97581abc13c11a3e4e69a520b1eaee0ab678002a20a8548034484d2b1341"
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
end
