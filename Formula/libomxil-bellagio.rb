class LibomxilBellagio < Formula
  desc "Mesa: cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://downloads.sourceforge.net/project/omxil/omxil/Bellagio%200.9.3/libomxil-bellagio-0.9.3.tar.gz"
  sha256 "593c0729c8ef8c1467b3bfefcf355ec19a46dd92e31bfc280e17d96b0934d74c"
  revision 1

  bottle do
    sha256 "8f405db484d10304e0d5db1d7096b5f1ad672910ddb6b5a36ad5ee0219a11a1b" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-docs", "Build documentation"

  depends_on "doxygen" => :build if build.with? "docs"
  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --enable-doc=#{build.with?("docs") ? "yes" : "no"}
    ]

    system "./configure", *args
    ENV.deparallelize
    system "make"
    # system "make", "check" if build.with? "test"
    # 'make check' Fails with omxvolcontroltest.h:38:22: fatal error: OMX_Core.h: No such file or directory
    system "make", "install"
    system "make", "installcheck" if build.with? "test"
    doc.install Dir["doc/libomxil-bellagio/*"] if build.with? "docs"

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
