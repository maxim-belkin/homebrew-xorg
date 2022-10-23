class Xrefresh < Formula
  desc "X.Org Applications: xrefresh"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrefresh-1.0.6.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xrefresh-1.0.6.tar.bz2"
  sha256 "287dfb9bb7e8d780d07e672e3252150850869cb550958ed5f8401f0835cd6353"
  revision 1

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/xrefresh-1.0.6_1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0e1ca38f4323c89b59672723ff4e423deb0379446c4bd928fbca3efc50f02fe1"
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
