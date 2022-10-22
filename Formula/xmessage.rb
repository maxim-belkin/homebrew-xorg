class Xmessage < Formula
  desc "X.Org Applications: xmessage"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xmessage-1.0.5.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xmessage-1.0.5.tar.bz2"
  sha256 "373dfb81e7a6f06d3d22485a12fcde6e255d58c6dee1bbaeb00c7d0caa9b2029"
  revision 1

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
