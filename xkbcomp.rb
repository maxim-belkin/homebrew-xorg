class Xkbcomp < Formula
  desc "X.Org Applications: xkbcomp"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xkbcomp-1.3.1.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xkbcomp-1.3.1.tar.bz2"
  sha256 "0304dc9e0d4ac10831a9ef5d5419722375ddbc3eac3ff4413094d57bc1f1923d"
  # tag "linuxbrew"

  bottle do
    sha256 "d78b21a398b359dfdd4f008f5e8abe53523147b3edfbad931138a3c17981abd2" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxkbfile"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb-config-root=#{Formula["libx11"].share}/X11/xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
