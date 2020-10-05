class Bdftopcf < Formula
  desc "X.Org Applications: bdftopcf"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/bdftopcf-1.1.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/bdftopcf-1.1.tar.bz2"
  sha256 "4b4df05fc53f1e98993638d6f7e178d95b31745c4568cee407e167491fd311a2"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "98cae531a07e4c3655895d68ff3e2af01a9a63af9de6e9605b7b1fa3fd542c8d" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros"=> :build
  depends_on "xorgproto" => :build
  depends_on "bzip2"
  depends_on "libxfont"

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
