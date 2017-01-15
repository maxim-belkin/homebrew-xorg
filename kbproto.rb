class Kbproto < Formula
  desc "X.Org Protocol Headers: kbproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/kbproto-1.0.7.tar.bz2"
  sha256 "f882210b76376e3fa006b11dbd890e56ec0942bc56e65d1249ff4af86f90b857"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "3d6b25f6545716ad960db544ddd46b60c5e73c46fcc4a8b6ebea34e8fcdaf478" => :x86_64_linux
  end

  option "with-specs",  "Build specifications"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("specs")
    depends_on "xmlto" => :build
    depends_on "fop" => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "xorg-sgml-doctools" => [:build, :recommended]
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make", "install"
  end
end
