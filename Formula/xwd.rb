class Xwd < Formula
  desc "X.Org Applications: xwd"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwd-1.0.8.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xwd-1.0.8.tar.bz2"
  sha256 "fbaa2b34163714fe7be22b60920ea4683f63b355babb1781aec2e452a033031b"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c49945f046db8b9ab5568c6f3a7d72e29dbb84125b4743f26de233902f69709b"
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "libxkbfile"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
