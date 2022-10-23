class Xlsclients < Formula
  desc "X.Org Applications: xlsclients"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsclients-1.1.4.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xlsclients-1.1.4.tar.bz2"
  sha256 "773f2af49c7ea2c44fba4213bee64325875c1b3c9bc4bbcd8dac9261751809c1"
  revision 1

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
