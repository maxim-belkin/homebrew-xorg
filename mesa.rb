class Mesa < Formula
  desc "Cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://mesa.freedesktop.org/archive/17.0.0/mesa-17.0.0.tar.xz"
  sha256 "39db3d59700159add7f977307d12a7dfe016363e760ad82280ac4168ea668481"
  revision 1

  bottle do
    sha256 "c4261b5848761366779d18b7ad50c86798ed1513249da942a7072623823822e3" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on :python => :build
  depends_on "flex" => :build
  depends_on "bison" => :build
  depends_on "libtool" => :build

  depends_on :x11
  depends_on "linuxbrew/xorg/libdrm"
  depends_on "systemd" # provides libudev <= needed by "gbm"
  depends_on "linuxbrew/xorg/libsha1"
  depends_on "llvm"
  depends_on "libelf" # radeonsi requires libelf when using llvm
  depends_on "linuxbrew/xorg/libomxil-bellagio"
  depends_on "linuxbrew/xorg/wayland" => :recommended
  depends_on "valgrind" => :recommended
  depends_on "linuxbrew/xorg/libglvnd" => :optional
  depends_on "linuxbrew/xorg/libva" => :recommended
  depends_on "linuxbrew/xorg/libvdpau"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" => :build

  #
  # There is a circular dependency between Mesa and libva:
  # libva should be installed:
  #  1. before Mesa with "disable-egl" and "disable-egl" options  [libva formula]
  #  2. after  Mesa without the above two options                 [this formula]
  #

  resource "mako" do
    url "https://files.pythonhosted.org/packages/56/4b/cb75836863a6382199aefb3d3809937e21fa4cb0db15a4f4ba0ecc2e7e8e/Mako-1.0.6.tar.gz"
    sha256 "48559ebd872a8e77f92005884b3d88ffae552812cdf17db6768e5c3be5ebbe0d"
  end

  resource "libva" do
    url "https://www.freedesktop.org/software/vaapi/releases/libva/libva-1.7.3.tar.bz2"
    sha256 "22bc139498065a7950d966dbdb000cad04905cbd3dc8f3541f80d36c4670b9d9"
  end

  patch :p1 do
    url "https://gist.githubusercontent.com/rwhogg/088a3e771be0f0556d2286c034544d18/raw/efd587120964745a61a2571a431ffc38341dc37c/mesa-patch-from-linux-from-scratch.patch"
    sha256 "53492ca476e3df2de210f749983e17de4bec026a904db826acbcbd1ef83e71cd"
  end

  def install
    # inreplace "configure.ac", "$SED -i -e 's/brw_blorp.cpp/brw_blorp.c/'", "# $SED -i -e 's/brw_blorp.cpp/brw_blorp.c/'"

    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    resource("mako").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

    args = %W[
      CFLAGS=#{ENV.cflags}
      CXXFLAGS=#{ENV.cflags}
      --disable-silent-rules
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-texture-float
      --enable-gles1
      --enable-gles2
      --enable-osmesa
      --enable-xa
      --enable-gbm
      --with-egl-platforms=drm,x11,surfaceless#{build.with?("wayland") ? ",wayland" : ""}
      --with-gallium-drivers=i915,nouveau,r300,r600,radeonsi,svga,swrast,swr
      --enable-glx-tls
      --enable-dri
      --enable-dri3
      --enable-gallium-tests
      --enable-glx
      --enable-opengl
      --enable-shared-glapi
      --enable-va
      --enable-vdpau
      --enable-xvmc
      --disable-llvm-shared-libs
      --with-dri-drivers=i965,nouveau,radeon,r200,swrast
      --with-sha1=libsha1
      --enable-gallium-llvm
      --enable-sysfs
    ]

    # enable-opencl => needs libclc
    # enable-gallium-osmesa => mutually exclusive with enable-osmesa

    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"
    args << "--enable-libglvnd" if build.with? "libglvnd"

    inreplace "bin/ltmain.sh", /.*seems to be moved"/, '#\1seems to be moved"'

    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j6" if ENV["CIRCLECI"]

    system "./autogen.sh", *args
    system "make"
    system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}"
    system "make", "check" if build.with?("test")
    system "make", "install"
    system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}", "install"

    if build.with?("libva")
      resource("libva").stage do
        args = %W[
          --prefix=#{Formula["libva"].opt_prefix}
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
        ENV.append "EGL_CFLAGS", "-I#{Formula["libdrm"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libdrm"].opt_include}/libdrm"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxdamage"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["damageproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxfixes"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["fixesproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libx11"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxcb"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxxf86vm"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxext"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxau"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxdmcp"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["kbproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xextproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xf86vidmodeproto"].opt_include}"

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

  test do
    output = shell_output("ldd #{lib}/libGL.so").chomp
    libs = %w[
      libxcb-dri3.so.0
      libxcb-present.so.0
      libxcb-randr.so.0
      libxcb-xfixes.so.0
      libxcb-render.so.0
      libxcb-shape.so.0
      libxcb-sync.so.1
      libxshmfence.so.1
      libglapi.so.0
      libXext.so.6
      libXdamage.so.1
      libXfixes.so.3
      libX11-xcb.so.1
      libX11.so.6
      libxcb-glx.so.0
      libxcb-dri2.so.0
      libxcb.so.1
      libXxf86vm.so.1
      libdrm.so.2
    ]
    libs << "libexpat.so.1" if build.with?("wayland")

    libs.each do |lib|
      assert_match lib, output
    end
  end
end
