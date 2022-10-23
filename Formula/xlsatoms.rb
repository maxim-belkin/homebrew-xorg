class Xlsatoms < Formula
  desc "X.Org Applications: xlsatoms"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsatoms-1.1.3.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xlsatoms-1.1.3.tar.bz2"
  sha256 "57868f958c263976727881f3078e55b86b4a109dc578d2b92f5c6d690850a382"
  revision 1

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/xlsatoms-1.1.3_1"
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
