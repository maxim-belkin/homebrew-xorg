class Libfs < Formula
  desc "X.Org Libraries: libFS"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libFS-1.0.8.tar.bz2"
  sha256 "c8e13727149b2ddfe40912027459b2522042e3844c5cd228c3300fe5eef6bd0f"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "c34c9e927c96b690e558126c1df486650c8154984f5ad5582e8f2a6c0cfb17ec" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

  depends_on "linuxbrew/xorg/xtrans" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/xorgproto"

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
