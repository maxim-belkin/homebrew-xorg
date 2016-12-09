class Inputproto < Formula
  desc "X.Org Protocol Headers: inputproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "https://www.x.org/archive//individual/proto/inputproto-2.3.2.tar.bz2"
  sha256 "893a6af55733262058a27b38eeb1edc733669f01d404e8581b167f03c03ef31d"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "c4ec367162b7b7fdaf076672426134b2b04da6b3c271723dba597ec81c01e6fd" => :x86_64_linux
  end

  option "with-specs",  "Build specifications"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

  if build.with?("specs")
    depends_on "asciidoc" => :build
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make", "install"
  end
end
