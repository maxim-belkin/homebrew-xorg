class Mesa < Formula
  desc "Mesa: cross-driver middleware"
  homepage "http://dri.freedesktop.org"
  url "ftp://ftp.freedesktop.org/pub/mesa/12.0.1/mesa-12.0.1.tar.xz"
  sha256 "bab24fb79f78c876073527f515ed871fc9c81d816f66c8a0b051d8d653896389"

  option "without-test", "Skip compile-time tests"
  option "with-static",   "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on :python => :build
  depends_on "libtool" => :build

  resource "mako" do
    url "https://pypi.python.org/packages/7a/ae/925434246ee90b42e8ef57d3b30a0ab7caf9a2de3e449b876c56dcb48155/Mako-1.0.4.tar.gz"
    sha256 "fed99dbe4d0ddb27a33ee4910d8708aca9ef1fe854e668387a9ab9a90cbf9059"
  end

  depends_on "flex"  => :build
  depends_on "bison" => :build

  depends_on "xorg" # TODO: figure out which packages exactly are used and depend on them only
  depends_on "libdrm"
  depends_on "systemd"
  depends_on "llvm"
  depends_on "libelf" # ?
  depends_on "libomxil-bellagio"
  depends_on "wayland" => :recommended # => HEAD is preferred
  depends_on "libpthread-stubs" => :build

  #
  # Trivia:
  # There is a circular dependency with Mesa.
  #
  # Libva should be installed:
  #  1. before Mesa with "disable-egl" and "disable-egl" options.
  #  2. after  Mesa without the above two options. ~> this package
  #

  depends_on "libva" => :recommended
  depends_on "autoconf" => :build if build.with?("libva") && build.with?("wayland")

  resource "libva" do
    url "https://www.freedesktop.org/software/vaapi/releases/libva/libva-1.7.0.tar.bz2"
    sha256 "a689bccbcc81a66b458e448377f108c057d3eee44a2e21a23c92c549dc8bc95f"
  end

  patch :p1 do
    url "http://www.linuxfromscratch.org/patches/downloads/mesa/mesa-12.0.1-add_xdemos-1.patch"
    sha256 "53492ca476e3df2de210f749983e17de4bec026a904db826acbcbd1ef83e71cd"
  end

  def install
    resource("mako").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

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

        ### Set environment flags:
        # $ pkg-config --cflags egl | tr ' ' '\n'
        # $ pkg-config --cflags gl  | tr ' ' '\n'
        ENV["EGL_CFLAGS"] = "-I#{include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libdrm"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libdrm"].include}/libdrm"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxdamage"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["damageproto"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxfixes"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["fixesproto"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libx11"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxcb"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxxf86vm"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxext"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxau"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxdmcp"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xproto"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["kbproto"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xextproto"].include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xf86vidmodeproto"].include}"

        ENV["GLX_CFLAGS"] = ENV["EGL_CFLAGS"]

        ENV["EGL_LIBS"] = "-L#{lib} -lEGL"
        ENV["GLX_LIBS"] = "-L#{lib} -lGL"

        system "autoreconf", "-fi" if build.without?("wayland") # needed only if Wayland is not installed
        system "./configure", *args
        system "make"
        system "make", "install"
      end
    end
  end
end
