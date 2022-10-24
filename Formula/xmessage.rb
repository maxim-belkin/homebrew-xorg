class Xmessage < Formula
  desc "X.Org Applications: xmessage"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xmessage-1.0.6.tar.xz"
  mirror "https://ftp.x.org/pub/individual/app/xmessage-1.0.6.tar.xz"
  sha256 "d2eac545f137156b960877e052fcc8e29795ed735c02f7690fd7b439e6846a12"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8d848812fb900a888b2cc00b999e71179be4ad55ab2db59c0a82b58c5c447bc6"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libxaw"

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
    system "xmessage", "-timeout", "1", "Hello Homebrew"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
