class Xmessage < Formula
  desc "X.Org Applications: xmessage"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xmessage-1.0.7.tar.xz"
  sha256 "703fccb7a0b772d61d7e603c189b9739866aa97ba985c727275420f829a30356"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8d848812fb900a888b2cc00b999e71179be4ad55ab2db59c0a82b58c5c447bc6"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libx11"
  depends_on "libxaw"
  depends_on "libxt"

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
    system bin/"xmessage", "-timeout", "1", "Hello Homebrew"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
