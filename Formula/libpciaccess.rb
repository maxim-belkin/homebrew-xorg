class Libpciaccess < Formula
  desc "X.Org Libraries: libpciaccess"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/pub/individual/lib/libpciaccess-0.13.5.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/lib/libpciaccess-0.13.5.tar.bz2"
  sha256 "752c54e9b3c311b4347cb50aea8566fa48eab274346ea8a06f7f15de3240b999"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "b9b7b1f2ed076e28f484c0ea6cd9b5e89ceb79d18457899868cb9857b881ce2b" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--disable-static" if build.without?("static")

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
