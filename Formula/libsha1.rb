class Libsha1 < Formula
  desc "Tiny library providing SHA1 implementation"
  homepage "https://raw.githubusercontent.com/dottedmag/libsha1/master/README"
  url "https://github.com/dottedmag/libsha1.git"
  version "0.3"

  bottle do
    cellar :any
    sha256 "3ff1d504fc8fd266bf7d7e4c67c2afd0bb56e8e2525507d9e2a69a6e76e8c714" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

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
