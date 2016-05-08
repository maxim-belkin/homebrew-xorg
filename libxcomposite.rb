# libxcomposite: Build a bottle for Linuxbrew
class Libxcomposite < Formula
  desc "X.Org Libraries: libXcomposite"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXcomposite-0.4.4.tar.bz2"
  sha256 "ede250cd207d8bee4a338265c3007d7a68d5aca791b6ac41af18e9a2aeb34178"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" =>  :build
  depends_on "compositeproto" =>  :build
  depends_on "libx11"
  depends_on "libxfixes"  =>  :build

  # Configure script says that libXcomposite depends on xmlto
  # which  is used to regenerate documentation.
  # But xmlto is never used (according to the log)
  # so we do not add this dependency.

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
    system "make", "check" if build.with?("check")
    system "make", "install"
  end
end
