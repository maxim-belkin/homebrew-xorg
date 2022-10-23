class Sessreg < Formula
  desc "X.Org Applications: sessreg"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/sessreg-1.1.2.tar.bz2"
  sha256 "dfcb9e954273ace63879aec053c7880466f8755752a35aa9ced3fa5f04fd2c33"

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/sessreg-1.1.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9a228b4491c2b841281547e5b55015e7f4e2a97890d14a6d6baf58c50e6d65ca"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build

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
