class Mkfontscale < Formula
  desc "X.Org Applications: mkfontscale"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/mkfontscale-1.1.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/mkfontscale-1.1.2.tar.bz2"
  sha256 "8c6d5228af885477b9aec60ca6f172578e7d2de42234357af62fb00439453f20"
  # tag "linuxbrew"

  option "with-bzip2", "Support bzip2 compressed bitmap fonts"

  depends_on "pkg-config" =>  :build
  depends_on "libfontenc"
  depends_on "freetype"
  depends_on "bzip2" if build.with?("bzip2")
  depends_on "xproto" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--with-bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
