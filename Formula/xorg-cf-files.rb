class XorgCfFiles < Formula
  desc "X.Org Utilities: xorg-cf-files"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/util/xorg-cf-files-1.0.6.tar.bz2"
  mirror "https://www.x.org/archive/individual/util/xorg-cf-files-1.0.6.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/util/xorg-cf-files-1.0.6.tar.bz2"
  sha256 "4dcf5a9dbe3c6ecb9d2dd05e629b3d373eae9ba12d13942df87107fdc1b3934d"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "e72d52ca71ed83adc8ba5e5140fe5ffcb74486a899e1486aa13bdc5eced8c2d9" => :x86_64_linux
  end

  depends_on "font-util" => :build
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
