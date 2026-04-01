class Xlsfonts < Formula
  desc "X.Org Applications: xlsfonts"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsfonts-1.0.8.tar.xz"
  sha256 "807f909eace684b866fc63b3e962729c120822a6c96e051ff51cf350b3ffb6cd"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4b1085126e36a904bc7179216e7f554aad03279d74dd8c4dac2b02894299e7b3"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xorgproto" => :build
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

  test do
    assert_predicate bin/"xlsfonts", :executable?
  end
end
