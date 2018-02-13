class Xlsclients < Formula
  desc "X.Org Applications: xlsclients"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsclients-1.1.3.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xlsclients-1.1.3.tar.bz2"
  sha256 "5d9666fcc6c3de210fc70d5a841a404955af709a616fde530fe4e8f7723e3d3d"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "5d7dbf8acf9f395456e20cd8b82fb4d118a686924da4311e07e46606d541417d" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
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
