# xkill: Build a bottle for Linuxbrew (again)
class Xkill < Formula
  desc "X.Org Applications: xkill"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xkill-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xkill-1.0.4.tar.bz2"
  sha256 "88ef2a304f32f24b255e879f03c1dcd3a2be3e71d5562205414f267d919f812e"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "xproto" => :build
  depends_on "libx11"
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
