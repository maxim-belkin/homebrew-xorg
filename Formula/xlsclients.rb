class Xlsclients < Formula
  desc "X.Org Applications: xlsclients"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsclients-1.1.4.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xlsclients-1.1.4.tar.bz2"
  sha256 "773f2af49c7ea2c44fba4213bee64325875c1b3c9bc4bbcd8dac9261751809c1"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "5d7dbf8acf9f395456e20cd8b82fb4d118a686924da4311e07e46606d541417d" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" => :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libxcb"

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
