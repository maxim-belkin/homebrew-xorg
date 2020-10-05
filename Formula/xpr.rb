class Xpr < Formula
  desc "X.Org Applications: xpr"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xpr-1.0.5.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xpr-1.0.5.tar.bz2"
  sha256 "b936e0f1f8d63f5ad097a0bbdce2e67c34f5d49b7263f32a832ff62d394d1e1f"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "06dcc8d2607f2e5da1ebf0ed9aefc8cff336aad844320024b5cd0b16e1628ebf" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libxmu"

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
