class LibpthreadStubs < Formula
  desc "X.Org Libraries: libpthread-stubs"
  homepage "https://www.x.org/"
  url "https://xcb.freedesktop.org/dist/libpthread-stubs-0.4.tar.bz2"
  sha256 "e4d05911a3165d3b18321cc067fdd2f023f06436e391c6a28dff618a78d2e733"
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
    assert File.exist? "#{lib}/pkgconfig/pthread-stubs.pc"
  end
end
