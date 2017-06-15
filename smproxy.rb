class Smproxy < Formula
  desc "X.Org Applications: smproxy"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/smproxy-1.0.6.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/smproxy-1.0.6.tar.bz2"
  sha256 "6cf19155a2752237f36dbf8bc4184465ea190d2652f887faccb4e2a6ebf77266"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "0c02e96efa8483785b137dcae94a9e76f7f2a42a51263a464d5e42aea83a9b11" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libsm"
  depends_on "linuxbrew/xorg/libice"
  depends_on "linuxbrew/xorg/libxt"
  depends_on "linuxbrew/xorg/libxmu"
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
