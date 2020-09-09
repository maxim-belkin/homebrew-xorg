class UtilMacros < Formula
  desc "X.Org util-macros"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/util/util-macros-1.19.2.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/util/util-macros-1.19.2.tar.bz2"
  sha256 "d7e43376ad220411499a79735020f9d145fdc159284867e99467e0d771f3e712"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "02b0459adfed7cedc617f47c9e28f507169a1965643ff58a816ba8625d0feaa0" => :x86_64_linux
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]

    system "./configure", *args
    system "make", "install"
  end
end
