class Xprop < Formula
  desc "X.Org Applications: xprop"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xprop-1.2.3.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xprop-1.2.3.tar.bz2"
  sha256 "d22afb28c86d85fff10a50156a7d0fa930c80ae865d70b26d805fd28a17a521b"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "88570f896f5181fc75405867ecdabc6d901b5d21dfe54c619430d9b5cb521ec1" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/libx11"

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
