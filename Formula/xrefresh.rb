class Xrefresh < Formula
  desc "X.Org Applications: xrefresh"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrefresh-1.0.6.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xrefresh-1.0.6.tar.bz2"
  sha256 "287dfb9bb7e8d780d07e672e3252150850869cb550958ed5f8401f0835cd6353"
  revision 1
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"

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
