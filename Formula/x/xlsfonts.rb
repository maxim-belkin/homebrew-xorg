class Xlsfonts < Formula
  desc "X.Org Applications: xlsfonts"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsfonts-1.0.9.tar.xz"
  sha256 "a6a2e291801458d92510263b175d16f98024dc3816ebddbde79b5009f6c3b065"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "df7f87cf4e21e913e174a415cf2356a5af3537ca3226ee893e6471be3d3ceb01"
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
