class Xtrans < Formula
  desc "X.Org Libraries: xtrans"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/xtrans-1.4.0.tar.bz2"
  sha256 "377c4491593c417946efcd2c7600d1e62639f7a8bbca391887e2c4679807d773"
  # tag "linuxbrew"

  livecheck do
    url "https://ftp.x.org/archive/individual/lib/"
    regex(/xtrans-([0-9.]+)\.tar.bz2/)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "71a00abeb9be73954af2152826a58370a9aada5a4eb02f3db480c0df5153cdb7" => :x86_64_linux
  end

  option "with-docs", "Build documentation"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/0b466fe45991ae0f8b11a68d8fd0bf48198fc395/Patches/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with? "docs"
    depends_on "xmlto" => :build
    depends_on "fop"     => [:build, :recommended]
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
      --enable-docs=#{build.with?("docs") ? "yes" : "no"}
    ]

    # Fedora systems do not provide sys/stropts.h
    inreplace "Xtranslcl.c", "# include <sys/stropts.h>", "# include <sys/ioctl.h>"

    system "./configure", *args
    system "make", "install"
  end
end
