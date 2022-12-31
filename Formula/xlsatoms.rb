class Xlsatoms < Formula
  desc "X.Org Applications: xlsatoms"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xlsatoms-1.1.4.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xlsatoms-1.1.4.tar.gz"
  sha256 "e3b4dce0e6bf3b60bc308ed184d2dc201ea4af6ce03f0126aa303ccd1ccb1237"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3f42fd83ac033588479d64709c26726d25eea717dbc5dffd9c50bf64cd75f7a6"
  end

  depends_on "pkg-config" => :build
  depends_on "libxcb"

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
