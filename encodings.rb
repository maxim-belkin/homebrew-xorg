class Encodings < Formula
  desc "X.Org Fonts: encodings"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/encodings-1.0.4.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/encodings-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/encodings-1.0.4.tar.bz2"
  sha256 "ced6312988a45d23812c2ac708b4595f63fd7a49c4dcd9f66bdcd50d1057d539"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "mkfontscale" => :build # ugh, circular dependencies...

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

    prefix.install "README" => "encodings.md"
  end
end
