class X11perf < Formula
  desc "X server performance testing tool"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/x11perf-1.6.1.tar.bz2"
  sha256 "1c7e0b8ffc2794b4ccf11e04d551823abe0ea47b4f7db0637390db6fbe817c34"
  revision 1
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxft" # not critical
  depends_on "libxmu"
  depends_on "libxrender" # critical

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
    cmd = "x11perf -repeat 1 -time 1 -rect1"
    assert_match /Sync time adjustment is \d\.\d{4} msecs\./, shell_output(cmd).chomp
  end
end
