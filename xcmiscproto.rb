class Xcmiscproto < Formula
  desc "X.Org Protocol Headers: xcmiscproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/xcmiscproto-1.2.2.tar.bz2"
  sha256 "b13236869372256c36db79ae39d54214172677fb79e9cdc555dceec80bd9d2df"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "46caab02275016fa14276b31198a280a928336004767f5808a78617efbb8814f" => :x86_64_linux
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
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make", "install"
  end
end
