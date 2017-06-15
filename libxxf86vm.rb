class Libxxf86vm < Formula
  desc "X.Org Libraries: libXxf86vm"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXxf86vm-1.1.4.tar.bz2"
  sha256 "afee27f93c5f31c0ad582852c0fb36d50e4de7cd585fcf655e278a633d85cd57"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "e15486ac648419eadda5f5c394438f49d6b7b50dae3a297af61a6a7cf9a1ef03" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/xproto"     => :build
  depends_on "linuxbrew/xorg/xextproto"  => :build
  depends_on "linuxbrew/xorg/xf86vidmodeproto" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
