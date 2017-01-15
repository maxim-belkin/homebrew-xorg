class Videoproto < Formula
  desc "X.Org Protocol Headers: videoproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/videoproto-2.3.3.tar.bz2"
  sha256 "c7803889fd08e6fcaf7b68cc394fb038b2325d1f315e571a6954577e07cca702"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "131b8b6037c14e9f384bf80f004009b2b85df8ba6f75b66996cf5b012b17d4bf" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end
end
