class Recordproto < Formula
  desc "X.Org Protocol Headers: recordproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/recordproto-1.14.2.tar.bz2"
  sha256 "a777548d2e92aa259f1528de3c4a36d15e07a4650d0976573a8e2ff5437e7370"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "e23cb1e1cb66b34322fdd448fd79c684b38acb1b0fc7c4f0f6231fe4028ea97e" => :x86_64_linux
  end

  option "with-specs", "Build specifications"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("specs")
    depends_on "xmlto" => :build
    depends_on "fop" => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => [:build, :recommended]
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]

    # Be explicit about the configure flags
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make", "install"
  end
end
