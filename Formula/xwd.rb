class Xwd < Formula
  desc "X.Org Applications: xwd"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwd-1.0.7.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xwd-1.0.7.tar.bz2"
  sha256 "cd6815b8b9e0b98e284d3d732fb12162159cb9dcee4f45a7d4c0bd8b308a6794"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "c7fb19fb47fe77f00f1e11950c0f2da90d13f148cc984c3718683470fd29f644" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxkbfile"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
