class Xwud < Formula
  desc "X.Org Applications: xwud"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwud-1.0.7.tar.gz"
  sha256 "371df65cea6b0ca281f9944337b82bb3bcee624618548e7b7077c2e32574c3e0"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "58f3018ac08a0d091e12665a5f8ef94ef69c99e27ec6bed69f30290ccbbd85fc"
  end

  depends_on "pkg-config" => :build
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
    assert_predicate bin/"xwud", :executable?
  end
end
