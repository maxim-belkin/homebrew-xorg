class Iceauth < Formula
  desc "X.Org Applications: iceauth"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/iceauth-1.0.9.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/iceauth-1.0.8.tar.gz"
  sha256 "5ca274cf210453e7d7cf5c827a2fbc92149df83824f99a27cde17e1f20324dc6"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2d2f9f95d07b558f7174b1650396711c07ddbb08dfc1ef3d46afe7bea82add98"
  end

  depends_on "pkg-config" => :build
  depends_on "splint" => [:build, :optional]
  depends_on "xorgproto" => :build
  depends_on "libice"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-lint=#{build.with?("splint") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
