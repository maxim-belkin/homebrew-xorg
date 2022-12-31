class Sessreg < Formula
  desc "X.Org Applications: sessreg"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/sessreg-1.1.3.tar.gz"
  sha256 "6e3e917e881132a7a9ccb181ddd83fe08a99668892455d808c911ad38beea215"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9a228b4491c2b841281547e5b55015e7f4e2a97890d14a6d6baf58c50e6d65ca"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build

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
end
