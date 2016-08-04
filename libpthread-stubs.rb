class LibpthreadStubs < Formula
  desc "X.Org Libraries: libpthread-stubs"
  homepage "http://www.x.org/"
  url "https://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2"
  sha256 "35b6d54e3cc6f3ba28061da81af64b9a92b7b757319098172488a660e3d87299"
  # tag "linuxbrew"

  depends_on "pkg-config"  => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert File.exist? "#{lib}/pkgconfig/pthread-stubs.pc"
  end
end
