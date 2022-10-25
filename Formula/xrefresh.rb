class Xrefresh < Formula
  desc "X.Org Applications: xrefresh"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrefresh-1.0.7.tar.xz"
  mirror "https://ftp.x.org/pub/individual/app/xrefresh-1.0.7.tar.xz"
  sha256 "a9f1d635f2f42283d0174e94d09ab69190c227faa5ab542bfe15ed9607771b1e"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d3bdd51230a2632903c4dfd139c02e7e230ce6967901f2a7a6f77ecfff8e6e4e"
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
end
