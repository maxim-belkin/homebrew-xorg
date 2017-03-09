class Xrefresh < Formula
  desc "X.Org Applications: xrefresh"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xrefresh-1.0.5.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xrefresh-1.0.5.tar.bz2"
  sha256 "3213671b0a8a9d1e8d1d5d9e3fd86842c894dd9acc1be2560eda50bc1fb791d6"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "d67050f24859d830f0d9abf1427651125cd70027c72e1ec649e8e1bf2b046158" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/xproto" => :build
  depends_on "linuxbrew/xorg/libx11"

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
