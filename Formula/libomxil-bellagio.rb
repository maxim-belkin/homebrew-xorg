class LibomxilBellagio < Formula
  desc "Mesa: cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://downloads.sourceforge.net/project/omxil/omxil/Bellagio%200.9.3/libomxil-bellagio-0.9.3.tar.gz"
  sha256 "593c0729c8ef8c1467b3bfefcf355ec19a46dd92e31bfc280e17d96b0934d74c"
  revision 1

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    ENV.refurbish_args # needed for `./configure`

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
    ]
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./configure", *args
    ENV.deparallelize
    system "make"
    system "make", "install"

    if build.with? "test"
      ["audio_effects", "resource_manager"].each do |f|
        inreplace "test/components/#{f}/Makefile" do |s|
          s.gsub! /^bellagio_LDADD = -lomxil-bellagio$/,
            "bellagio_LDADD = -L$(top_srcdir)/src/.libs -lomxil-bellagio"
        end
      end
      system "make", "check"
    end

  end
end
