class Iceauth < Formula
  desc "X.Org Applications: iceauth"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/iceauth-1.0.8.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/iceauth-1.0.8.tar.bz2"
  sha256 "e6ee213a217265cc76050e4293ea70b98c32dce6505c6421227efbda62ab60c6"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "splint" => [:build, :optional]
  depends_on "xorgproto" => :build
  depends_on "libice"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-lint=#{build.with?("splint") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
