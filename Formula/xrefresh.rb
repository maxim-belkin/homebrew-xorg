class Xrefresh < Formula
  desc "X.Org Applications: xrefresh"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrefresh-1.0.7.tar.xz"
  mirror "https://ftp.x.org/pub/individual/app/xrefresh-1.0.7.tar.xz"
  sha256 "a9f1d635f2f42283d0174e94d09ab69190c227faa5ab542bfe15ed9607771b1e"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0e1ca38f4323c89b59672723ff4e423deb0379446c4bd928fbca3efc50f02fe1"
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
