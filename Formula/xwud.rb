class Xwud < Formula
  desc "X.Org Applications: xwud"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwud-1.0.5.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xwud-1.0.5.tar.bz2"
  sha256 "99997051f8a892313f22edf41dab45864e86e7062ee9012d5dbb6a40fc6b10a9"
  revision 1
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"

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
