class XorgFonts < Formula
  desc "X.Org Fonts"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://gist.githubusercontent.com/maxim-belkin/6fd6422cbe4da6ea0555d7a8d9911bc2/raw/c38d109967382d35f9f8a89542c18abbfb27cf88/README.md"
  version  "20160522"
  sha256   "3baf64afb29129ea9f74d5ae5a223b072d0911d96283f834e37d8f65d751c5d7"
  revision 1

  livecheck do
    skip "Formula only installs other formulae"
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3a2c3a2f61a41b0a1f8216295b9383c20f186eb1dd2424d7f1f8741d0816f32a"
  end

  depends_on "font-util" => :build
  depends_on "maxim-belkin/xorg/encodings"
  depends_on "maxim-belkin/xorg/font-adobe-100dpi"
  depends_on "maxim-belkin/xorg/font-adobe-75dpi"
  depends_on "maxim-belkin/xorg/font-adobe-utopia-100dpi"
  depends_on "maxim-belkin/xorg/font-adobe-utopia-75dpi"
  depends_on "maxim-belkin/xorg/font-adobe-utopia-type1"
  depends_on "maxim-belkin/xorg/font-alias"
  depends_on "maxim-belkin/xorg/font-arabic-misc"
  depends_on "maxim-belkin/xorg/font-bh-100dpi"
  depends_on "maxim-belkin/xorg/font-bh-75dpi"
  depends_on "maxim-belkin/xorg/font-bh-lucidatypewriter-100dpi"
  depends_on "maxim-belkin/xorg/font-bh-lucidatypewriter-75dpi"
  depends_on "maxim-belkin/xorg/font-bh-ttf"
  depends_on "maxim-belkin/xorg/font-bh-type1"
  depends_on "maxim-belkin/xorg/font-bitstream-100dpi"
  depends_on "maxim-belkin/xorg/font-bitstream-75dpi"
  depends_on "maxim-belkin/xorg/font-bitstream-type1"
  depends_on "maxim-belkin/xorg/font-cronyx-cyrillic"
  depends_on "maxim-belkin/xorg/font-cursor-misc"
  depends_on "maxim-belkin/xorg/font-daewoo-misc"
  depends_on "maxim-belkin/xorg/font-dec-misc"
  depends_on "maxim-belkin/xorg/font-ibm-type1"
  depends_on "maxim-belkin/xorg/font-isas-misc"
  depends_on "maxim-belkin/xorg/font-jis-misc"
  depends_on "maxim-belkin/xorg/font-micro-misc"
  depends_on "maxim-belkin/xorg/font-misc-cyrillic"
  depends_on "maxim-belkin/xorg/font-misc-ethiopic"
  depends_on "maxim-belkin/xorg/font-misc-meltho"
  depends_on "maxim-belkin/xorg/font-misc-misc"
  depends_on "maxim-belkin/xorg/font-mutt-misc"
  depends_on "maxim-belkin/xorg/font-schumacher-misc"
  depends_on "maxim-belkin/xorg/font-screen-cyrillic"
  depends_on "maxim-belkin/xorg/font-sony-misc"
  depends_on "maxim-belkin/xorg/font-sun-misc"
  depends_on "maxim-belkin/xorg/font-winitzki-cyrillic"
  depends_on "maxim-belkin/xorg/font-xfree86-type1"

  def install
    ohai "Xorg Fonts have been installed!"
    prefix.install "README.md" => "xorg-fonts.md"
  end
end
