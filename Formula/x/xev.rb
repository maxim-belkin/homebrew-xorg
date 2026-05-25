class Xev < Formula
  desc "X.Org Applications: xev"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xev-1.2.7.tar.xz"
  sha256 "95167895924de58e34b1013b2b0c8476e90d0888c6c39e7ae9bc35e3a19dba04"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8ec1c0f5f873cdf40c5b115390a96a3cbd53933d506d2e532a976cdd7f986b93"
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

  test do
    assert_predicate bin/"xev", :executable?
  end
end
