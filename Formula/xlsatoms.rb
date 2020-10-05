class Xlsatoms < Formula
  desc "X.Org Applications: xlsatoms"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsatoms-1.1.3.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xlsatoms-1.1.3.tar.bz2"
  sha256 "57868f958c263976727881f3078e55b86b4a109dc578d2b92f5c6d690850a382"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "3a65ab7571ad039464f9fd843347ae51fe0c210ce5c6d6f6f9b14fac357ceff4" => :x86_64_linux
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
