class Xlsatoms < Formula
  desc "X.Org Applications: xlsatoms"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsatoms-1.1.3.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xlsatoms-1.1.3.tar.bz2"
  sha256 "57868f958c263976727881f3078e55b86b4a109dc578d2b92f5c6d690850a382"
  revision 1

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
