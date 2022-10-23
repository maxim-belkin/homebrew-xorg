class Xmessage < Formula
  desc "X.Org Applications: xmessage"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xmessage-1.0.5.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xmessage-1.0.5.tar.bz2"
  sha256 "373dfb81e7a6f06d3d22485a12fcde6e255d58c6dee1bbaeb00c7d0caa9b2029"
  revision 1

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/xmessage-1.0.5_1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "812ad59c57ab09bdb7cbde8618dd338b56bc9ee90b20a8f5b5dfc8395e4af465"
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
