class Xrandr < Formula
  desc "X.Org Applications: xrandr"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrandr-1.5.4.tar.xz"
  sha256 "2cafccb2aaf2491a4068676117a0d4f90ab307724b96fffc54cd1da953779400"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f4e4578acc8c8fabfb6c73baba109325c4267d4432fef85aa7d70ecc5ade4e1a"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxrandr"
  depends_on "libxrender"

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
    rm bin/"xkeystone"
  end

  test do
    assert_predicate bin/"xrandr", :executable?
  end
end
