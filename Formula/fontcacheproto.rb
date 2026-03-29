class Fontcacheproto < Formula
  desc "X.Org Proto: fontcacheproto"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/proto/fontcacheproto-0.1.3.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/proto/fontcacheproto-0.1.3.tar.bz2"
  sha256 "1dcaa659d416272ff68e567d1910ccc1e369768f13b983cffcccd6c563dbe3cb"
  license "MIT"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "395922132d1b2fa5896de451f2c89f492a77377cca3a3affd49772dbd61b9fd4"
  end

  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_path_exists lib/"pkgconfig/fontcacheproto.pc"
  end
end
