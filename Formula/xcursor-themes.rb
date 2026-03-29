class XcursorThemes < Formula
  desc "X.Org: redglass and whiteglass animated cursor themes"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/archive/individual/data/xcursor-themes-1.0.7.tar.xz"
  sha256 "95bae8f48823d894a05bf42dfbf453674ab7dbdeb11e2bc079e8525ad47378c8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c2b0ea73e77ddf952f5cb64ef4f9f0e4e9d7c3fb709c577ce2d3b4ded6fed855"
  end

  depends_on "maxim-belkin/xorg/xcursorgen" => :build
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libxcursor"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-cursordir=#{pkgshare}/icons
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_predicate pkgshare/"icons", :directory?
  end
end
