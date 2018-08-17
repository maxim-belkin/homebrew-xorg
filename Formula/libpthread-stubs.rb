class LibpthreadStubs < Formula
  desc "X.Org Libraries: libpthread-stubs"
  homepage "https://www.x.org/"
  url "https://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2"
  sha256 "35b6d54e3cc6f3ba28061da81af64b9a92b7b757319098172488a660e3d87299"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "ab61c92ab2a15907df6a29d08963290c4896b1aa7939524932d343acbe7d8026" => :x86_64_linux
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
