class Xpr < Formula
  desc "X.Org Applications: xpr"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xpr-1.1.0.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xpr-1.1.0.tar.gz"
  sha256 "fabd02fb1a52358d521f1be7422738bc8c9b511a8d82a163888f628db6f6cb18"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d8b49e12e366bc955edb45d7f0cfd7e836f96eff0c7348c6fb67f66bf26d74b0"
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
