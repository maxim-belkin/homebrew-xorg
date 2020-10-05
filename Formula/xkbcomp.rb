class Xkbcomp < Formula
  desc "X.Org Applications: xkbcomp"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbcomp-1.4.2.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xkbcomp-1.4.2.tar.bz2"
  sha256 "6dd8bcb9be7e85bd7294abe261b8c7b0539d2fc93e41b80fb8bd013767ce8424"
  revision 1
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "b6fe122901d039129ed994361c3f767aa4fd30614daf64689b13d040a4bb3b38" => :x86_64_linux
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
      --with-xkb-config-root=#{Formula["libx11"].opt_share}/X11/xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
