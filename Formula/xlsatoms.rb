class Xlsatoms < Formula
  desc "X.Org Applications: xlsatoms"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsatoms-1.1.4.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xlsatoms-1.1.4.tar.gz"
  sha256 "e3b4dce0e6bf3b60bc308ed184d2dc201ea4af6ce03f0126aa303ccd1ccb1237"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "93fa50c8d032a0857abde4cca86b58431f10d19713ae0055d251f8962e753446"
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
