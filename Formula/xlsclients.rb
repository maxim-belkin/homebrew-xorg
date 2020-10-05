class Xlsclients < Formula
  desc "X.Org Applications: xlsclients"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsclients-1.1.4.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xlsclients-1.1.4.tar.bz2"
  sha256 "773f2af49c7ea2c44fba4213bee64325875c1b3c9bc4bbcd8dac9261751809c1"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "5f492f6aca3337a62a5e78c809244c50fe7c3dfb617c40b0c34e86a0f3b43c87" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "libxcb"

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
