class XorgCfFiles < Formula
  desc "X.Org Utilities: xorg-cf-files"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/util/xorg-cf-files-1.0.7.tar.bz2"
  mirror "https://www.x.org/archive/individual/util/xorg-cf-files-1.0.7.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/util/xorg-cf-files-1.0.7.tar.bz2"
  sha256 "74a771d5bb2189020399998dfa2329c3e038aa2e14dd3d4056144ed9a5976308"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "01642694c74d05f6fa5109980ebd84154cfdb9ff8d2a10ef69a980de022ef441"
  end

  depends_on "font-util" => :build
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
