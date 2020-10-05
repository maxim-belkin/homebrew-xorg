class XorgSgmlDoctools < Formula
  desc "X.Org SGML DocTools"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/doc/xorg-sgml-doctools-1.11.tar.gz"
  sha256 "986326d7b4dd2ad298f61d8d41fe3929ac6191c6000d6d7e47a8ffc0c34e7426"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "9ee67d30d91f5bb5bd26fbec461ec6e6898f4f9b395391720c50bebd6be98e48" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros"=> :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end
end
