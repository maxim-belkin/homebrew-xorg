class Xlsclients < Formula
  desc "X.Org Applications: xlsclients"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsclients-1.1.5.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xlsclients-1.1.5.tar.gz"
  sha256 "225d75e4c0b0929f16f974e20931ab85204b40098d92a5479b0b9379120637e5"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "76cafc4d5e68d68d8a78422886813083e1a3188617942aab13a760a77efb1fb8"
  end

  depends_on "pkg-config" => :build
  depends_on "libxcb"

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
