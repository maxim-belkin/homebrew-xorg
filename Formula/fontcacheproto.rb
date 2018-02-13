class Fontcacheproto < Formula
  desc "X.Org Proto: fontcacheproto"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/proto/fontcacheproto-0.1.3.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/proto/fontcacheproto-0.1.3.tar.bz2"
  sha256 "1dcaa659d416272ff68e567d1910ccc1e369768f13b983cffcccd6c563dbe3cb"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "9651b2ef34a2415b3c851959ec2a66d05c06aafad108bea465f996a9f8ad90c2" => :x86_64_linux
  end

  depends_on "pkg-config" => :build

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
