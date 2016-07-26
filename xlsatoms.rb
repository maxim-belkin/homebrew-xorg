# xlsatoms: Build a bottle for Linuxbrew
class Xlsatoms < Formula
  desc "X.Org Applications: xlsatoms"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xlsatoms-1.1.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xlsatoms-1.1.2.tar.bz2"
  sha256 "47e5dc7c3dbda6db2cf8c00cedac1722835c1550aa21cfdbc9ba83906694dea4"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
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
