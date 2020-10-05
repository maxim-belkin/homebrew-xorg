class Xrandr < Formula
  desc "X.Org Applications: xrandr"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrandr-1.5.1.tar.xz"
  sha256 "7bc76daf9d72f8aff885efad04ce06b90488a1a169d118dea8a2b661832e8762"
  revision 1

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "3fdd8ad40af36679848845b5ecfdbab0f577b08157f8fbc63470cb27d38b8fce" => :x86_64_linux
  end

  option "without-xkeystone", "Delete (broken) xkeystone script"

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxrandr"
  depends_on "libxrender"

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
    rm bin/"xkeystone" if build.without?("xkeystone")
  end
end
