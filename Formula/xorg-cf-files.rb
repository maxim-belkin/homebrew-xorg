class XorgCfFiles < Formula
  desc "X.Org Utilities: xorg-cf-files"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/util/xorg-cf-files-1.0.9.tar.xz"
  sha256 "07716eb1fe1fd1f8a1d6588457db0101cae70cb896d49dc65978c97b148ce976"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fe2e51ade9b853be3527f250f2d331b5c158d585ff9c7eb8cee81d9bc50fcd8a"
  end

  depends_on "font-util" => :build
  depends_on "pkg-config" => :build

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
    assert_predicate lib/"X11/config", :directory?
  end
end
