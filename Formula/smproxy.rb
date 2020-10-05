class Smproxy < Formula
  desc "X.Org Applications: smproxy"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/smproxy-1.0.6.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/smproxy-1.0.6.tar.bz2"
  sha256 "6cf19155a2752237f36dbf8bc4184465ea190d2652f887faccb4e2a6ebf77266"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "641cfafcf9d11c558039a4f482719a839d78e466431b7d6650d7588fb27784a2" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "libice"
  depends_on "libsm"
  depends_on "libx11"
  depends_on "libxmu"
  depends_on "libxt"

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
