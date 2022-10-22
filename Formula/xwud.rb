class Xwud < Formula
  desc "X.Org Applications: xwud"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwud-1.0.6.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xwud-1.0.6.tar.gz"
  sha256 "262171b0c434966ddbbe8a54afb9615567ad74d4cc2e823e14e51e099ec3ab0d"

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
