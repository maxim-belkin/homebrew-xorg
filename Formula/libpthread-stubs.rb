class LibpthreadStubs < Formula
  desc "X.Org Libraries: libpthread-stubs"
  homepage "https://www.x.org/"
  url "https://xcb.freedesktop.org/dist/libpthread-stubs-0.4.tar.bz2"
  sha256 "e4d05911a3165d3b18321cc067fdd2f023f06436e391c6a28dff618a78d2e733"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "b5075aa908c76b2ff95b14c0ece59a99caa84875c5c889e6d12a1b7153cd79a8" => :x86_64_linux
  end

  depends_on "pkg-config" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_predicate lib/"pkgconfig/pthread-stubs.pc", :exist?
  end
end
