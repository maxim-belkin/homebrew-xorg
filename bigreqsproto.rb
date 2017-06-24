class Bigreqsproto < Formula
  desc "X.Org Protocol Headers: bigreqsproto"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/bigreqsproto-1.1.2.tar.bz2"
  sha256 "462116ab44e41d8121bfde947321950370b285a5316612b8fce8334d50751b1e"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "204f49efe8ca9252a02645166810b3f1e8fe7d14e7298977cb41fc2bb3b945bd" => :x86_64_linux
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
    depends_on "fop" => %i(build recommended)
    depends_on "libxslt" => %i(build recommended)
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => :build
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
      --disable-dependency-tracking
    ]

    # Be explicit about the configure flags
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make", "install"
  end

  # def post_install
  #   if build.with?("specs")
  #     mkdir_p "#{Formula["xorg-sgml-doctools"].prefix}/share/doc"
  #     rm_f "#{Formula["xorg-sgml-doctools"].share}/doc/#{name}"
  #     ln_sf "#{doc}", "#{Formula["xorg-sgml-doctools"].share}/doc/#{name}"
  #   end
  # end
end
