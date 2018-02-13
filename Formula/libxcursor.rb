class Libxcursor < Formula
  desc "X.Org Libraries: libXcursor"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXcursor-1.1.14.tar.bz2"
  sha256 "9bc6acb21ca14da51bda5bc912c8955bc6e5e433f0ab00c5e8bef842596c33df"
  # tag "linuxbrew"

  bottle do
    sha256 "b416d2de1edef471cebc301b9865ae1ccd79480a6bae60685b637b2ca65f308a" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libxrender"
  depends_on "linuxbrew/xorg/libxfixes"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/fixesproto" => :build

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
