class LibomxilBellagio < Formula
  desc "Mesa: cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://downloads.sourceforge.net/project/omxil/omxil/Bellagio%200.9.3/libomxil-bellagio-0.9.3.tar.gz"
  sha256 "593c0729c8ef8c1467b3bfefcf355ec19a46dd92e31bfc280e17d96b0934d74c"

  bottle do
    sha256 "f9033e9fd118666ba8cb7cfb540cb62db69613e369e48a0c18b32c92b9b3aab0" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "autoreconf", "-fiv"
    system "./configure", *args
    ENV.deparallelize
    system "make"
    system "make", "install"
    system "make", "check" if build.with?("test")
  end
end
