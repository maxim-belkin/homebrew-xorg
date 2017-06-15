class XorgCfFiles < Formula
  desc "X.Org Utilities: xorg-cf-files"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/util/xorg-cf-files-1.0.6.tar.bz2"
  mirror "https://www.x.org/archive/individual/util/xorg-cf-files-1.0.6.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/util/xorg-cf-files-1.0.6.tar.bz2"
  sha256 "4dcf5a9dbe3c6ecb9d2dd05e629b3d373eae9ba12d13942df87107fdc1b3934d"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "3a198c7af0bc958b6936c9fc8486a54a0fd859c09e0e2f0d2f5e5ce094a04e33" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/font-util" => :build

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
