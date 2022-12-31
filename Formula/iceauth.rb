class Iceauth < Formula
  desc "X.Org Applications: iceauth"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/iceauth-1.0.9.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/iceauth-1.0.8.tar.gz"
  sha256 "5ca274cf210453e7d7cf5c827a2fbc92149df83824f99a27cde17e1f20324dc6"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9737443cc0c4d91932b90e3ae97f9146970702ef48f2a141836bad05edf6647c"
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
