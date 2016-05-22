class Mesa < Formula
  desc "Mesa: cross-driver middleware"
  homepage "http://dri.freedesktop.org"
  url "ftp://ftp.freedesktop.org/pub/mesa/11.2.2/mesa-11.2.2.tar.xz"
  sha256 "40e148812388ec7c6d7b6657d5a16e2e8dabba8b97ddfceea5197947647bdfb4"

  option "without-test", "Skip compile-time tests"
  option "with-static",   "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "xorg"
  depends_on "libdrm"
  depends_on "systemd"
  depends_on "llvm" => ["with-clang", "with-clang-extra-tools", "with-compiler-rt", "with-rtti", "with-shared"] # :head HAS TO BE HEAD!!!
  depends_on "libelf" #?
  depends_on "libomxil-bellagio"
  depends_on "wayland" => :recommended # => HEAD is preferred

  #
  # Trivia:
  # There is a circular dependency with Mesa.
  #
  # Libva should be installed:
  #  1. before Mesa with "disable-egl" and "disable-egl" options ~> this package
  #  2. after  Mesa without the above options.
  #
  # The second installations is hard-coded into Mesa as a post-installation step
  #

  depends_on "libva" => :recommended
  depends_on "autoconf" => :build if (build.with?("libva") && !build.without?("wayland"))

  resource "libva" do
    url "http://www.freedesktop.org/software/vaapi/releases/libva/libva-1.7.0.tar.bz2"
    sha256 "a689bccbcc81a66b458e448377f108c057d3eee44a2e21a23c92c549dc8bc95f"
  end

  # depends_on "util-macros" => :build
  # depends_on "autoconf" => :build
  # depends_on "libtool" => :build
  # depends_on "libpciaccess" => :build

  patch :p1 do
    url "http://www.linuxfromscratch.org/patches/blfs/svn/mesa-11.2.2-add_xdemos-1.patch"
    sha256 "53492ca476e3df2de210f749983e17de4bec026a904db826acbcbd1ef83e71cd"
  end

  def install
    args = %W[
      CFLAGS=-O2
      CXXFLAGS=-O2
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-texture-float
      --enable-gles1
      --enable-gles2
      --enable-osmesa
      --enable-xa
      --enable-gbm
      --enable-glx-tls
      --with-egl-platforms=drm,x11
      --with-gallium-drivers=nouveau,r300,r600,radeonsi,svga,swrast
      --disable-llvm-shared-libs
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./autogen.sh", *args
    system "make"
    system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}"
    system "make", "check" if build.with?("test")
    system "make", "install"
    system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}", "install"
  end

  def post_install
    if build.with?("libva")
      resource("libva").stage do
        args = %W[
          --prefix=#{Formula["libva"].prefix}
          --sysconfdir=#{etc}
          --localstatedir=#{var}
          --disable-dependency-tracking
          --disable-silent-rules
        ]

        # Be explicit about the configure flags
        args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

        system "autoreconf", "-fi" if build.without?("wayland") # needed only if Wayland is not installed
        system "./configure", *args
        system "make"
        system "make", "install"
      end
    end
  end
end
