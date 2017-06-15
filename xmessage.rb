class Xmessage < Formula
  desc "X.Org Applications: xmessage"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xmessage-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xmessage-1.0.4.tar.bz2"
  sha256 "bcdf4b461c439bb3ade6e1e41c47d6218b912da8e9396b7ad70856db2f95ab68"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "6a38fe5a90818f80f322186e6372684893e3b7362007eee0b45015f07e295415" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libxaw"

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
