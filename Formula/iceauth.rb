class Iceauth < Formula
  desc "X.Org Applications: iceauth"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/iceauth-1.0.8.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/iceauth-1.0.8.tar.bz2"
  sha256 "e6ee213a217265cc76050e4293ea70b98c32dce6505c6421227efbda62ab60c6"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "85faa34ab775ef0c8f6f539c97490dad0fb14654d3f01cb159e60965bb0e1a67" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libice"
  depends_on "splint" => [:build, :optional]

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
