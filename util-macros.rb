# util-macros: Build a bottle for Linuxbrew
class UtilMacros < Formula
  desc "Xorg util-macros"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://www.x.org/archive/individual/util/util-macros-1.19.0.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/util/util-macros-1.19.0.tar.bz2"
  sha256 "2835b11829ee634e19fa56517b4cfc52ef39acea0cd82e15f68096e27cbed0ba"
  # tag "linuxbrew"

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
