class Libxkbfile < Formula
  desc "X.Org Libraries: libxkbfile"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libxkbfile-1.1.0.tar.bz2"
  sha256 "758dbdaa20add2db4902df0b1b7c936564b7376c02a0acd1f2a331bd334b38c7"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "1e943ae60d762337e4b9f2b989e58bed91856640f5b2facbb31b5e9560f59b1d" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
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
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
