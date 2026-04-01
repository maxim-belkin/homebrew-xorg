class Xkbevd < Formula
  desc "X.Org Applications: xkbevd"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbevd-1.1.6.tar.gz"
  sha256 "e705872f9948091d934476d56937cfc94f93101d481ac9a556e4a47e8a955c75"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9cc5386e2826920c37ea28100956c56a8e407ace88c0b24e0e51686f76c5a3ae"
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "libxkbfile"

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
    assert_predicate bin/"xkbevd", :executable?
  end
end
