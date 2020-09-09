class Glu < Formula
  desc "Mesa OpenGL Utility library"
  homepage "https://cgit.freedesktop.org/mesa/glu"
  url "ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.1.tar.xz"
  sha256 "fb5a4c2dd6ba6d1c21ab7c05129b0769544e1d68e1e3b0ffecb18e73c93055bc"
  revision 1

  livecheck do
    url :head
    regex(/^(?:glu[._-])?v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "41b97b80a25d2ccd426ffbde60021eee2743540ee532b10bb6d521af63ff7cb5" => :x86_64_linux
  end

  head do
    url "https://gitlab.freedesktop.org/mesa/glu.git"

    depends_on "automake" => :build
  end

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "mesa"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./autogen.sh", *args if build.head?
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
