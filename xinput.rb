# xinput: Build a bottle for Linuxbrew
class Xinput < Formula
  desc "X.Org Applications: xinput"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xinput-1.6.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xinput-1.6.2.tar.bz2"
  sha256 "3694d29b4180952fbf13c6d4e59541310cbb11eef5bf888ff3d8b7f4e3aee5c4"
  # tag "linuxbrew"


  depends_on "pkg-config" =>  :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxi"
  depends_on "inputproto" => :build
  depends_on "libxrandr"
  depends_on "libxinerama"

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
