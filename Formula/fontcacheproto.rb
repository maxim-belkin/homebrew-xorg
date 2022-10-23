class Fontcacheproto < Formula
  desc "X.Org Proto: fontcacheproto"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/proto/fontcacheproto-0.1.3.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/proto/fontcacheproto-0.1.3.tar.bz2"
  sha256 "1dcaa659d416272ff68e567d1910ccc1e369768f13b983cffcccd6c563dbe3cb"

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/fontcacheproto-0.1.3"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ce9b29742ba8cb25b7dffe44796bbc8388fa8060967d892346a106d818c84e86"
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
end
