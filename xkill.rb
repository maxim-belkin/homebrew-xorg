class Xkill < Formula
  desc "X.Org Applications: xkill"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xkill-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xkill-1.0.4.tar.bz2"
  sha256 "88ef2a304f32f24b255e879f03c1dcd3a2be3e71d5562205414f267d919f812e"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "230a7daf447a45a70ec70effac3fecab5c56a3fc62c29987a4f2497e099048a7" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxmu"

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
