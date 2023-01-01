class Xkbevd < Formula
  desc "X.Org Applications: xkbevd"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbevd-1.1.5.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xkbevd-1.1.5.tar.gz"
  sha256 "5d6b65a417be57e19a76277601da83271b19de6e71cb0e8821441f6fb9973c47"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "698f291ad964a1babbadb6dda637de2d1f0d4e74001392adb8f125cdfd36eba7"
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
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
