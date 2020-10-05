class Mkfontscale < Formula
  desc "X.Org Applications: mkfontscale"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/mkfontscale-1.2.1.tar.bz2"
  sha256 "ca0495eb974a179dd742bfa6199d561bda1c8da4a0c5a667f21fd82aaab6bac7"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "36b4740ae2084a4738f1d5d556744142465c3ae603f9b2f20bca99d127a05ba4" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "freetype"
  depends_on "libfontenc"
  depends_on "bzip2" => :recommended

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-bzip2=#{build.with?("bzip2") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
