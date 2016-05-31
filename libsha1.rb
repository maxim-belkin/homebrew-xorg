class Libsha1 < Formula
  desc "Tiny library providing SHA1 implementation"
  homepage "https://raw.githubusercontent.com/dottedmag/libsha1/master/README"
  url "https://github.com/dottedmag/libsha1.git"
  version "0.3"

  option "with-static", "Build static libraries (not recommended)"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool"  => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-shared=yes
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "autoreconf", "-fiv"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
