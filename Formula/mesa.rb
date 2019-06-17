class Mesa < Formula
  desc "Cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://mesa.freedesktop.org/archive/mesa-19.0.6.tar.xz"
  sha256 "2db2f2fcaa4048b16e066fad76b8a93944f7d06d329972b0f5fd5ce692ce3d24"
  head "https://gitlab.freedesktop.org/mesa/mesa.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "f75fe92f0226107a47915b7699639e6c3c54f7b9c9713de9d5cb56c97046b44f" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "without-gpu", "Build without graphics hardware"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "flex" => :build
  depends_on "libtool" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" => :build
  depends_on "linuxbrew/xorg/libvdpau" => :build
  depends_on "linuxbrew/xorg/wayland-protocols" => [:recommended, :build]
  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "llvm@7" => :build
  depends_on "pkg-config" => :build
  depends_on "python@2" => :build
  depends_on "libelf"
  depends_on "linuxbrew/xorg/libdrm"
  depends_on "linuxbrew/xorg/libomxil-bellagio"
  depends_on "linuxbrew/xorg/libxdamage"
  depends_on "linuxbrew/xorg/libxrandr" => :build
  depends_on "linuxbrew/xorg/libxshmfence"
  depends_on "linuxbrew/xorg/libxv"
  depends_on "linuxbrew/xorg/libxvmc"
  depends_on "linuxbrew/xorg/libxxf86vm"
  depends_on "systemd" # provides libudev <= needed by "gbm" # failed with llvm@6 # radeonsi requires libelf when using llvm
  depends_on "linuxbrew/xorg/libva" => :recommended
  depends_on "valgrind" => :recommended
  depends_on "linuxbrew/xorg/libglvnd" => :optional

  #
  # There is a circular dependency between Mesa and libva:
  # libva should be installed:
  #  1. before Mesa with "disable-egl" and "disable-egl" options  [libva formula]
  #  2. after  Mesa without the above two options                 [this formula]
  #

  resource "mako" do
    url "https://files.pythonhosted.org/packages/f9/93/63f78c552e4397549499169198698de23b559b52e57f27d967690811d16d/Mako-1.0.10.tar.gz"
    sha256 "7165919e78e1feb68b4dbe829871ea9941398178fa58e6beedb9ba14acf63965"
  end

  resource "libva" do
    url "https://github.com/intel/libva/releases/download/2.4.0/libva-2.4.0.tar.bz2"
    sha256 "99263056c21593a26f2ece812aee6fe60142b49e6cd46cb33c8dddf18fc19391"
  end

  patch :p1 do
    url "https://gist.githubusercontent.com/rwhogg/088a3e771be0f0556d2286c034544d18/raw/efd587120964745a61a2571a431ffc38341dc37c/mesa-patch-from-linux-from-scratch.patch"
    sha256 "53492ca476e3df2de210f749983e17de4bec026a904db826acbcbd1ef83e71cd"
  end

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j2" if ENV["CIRCLECI"]

    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    resource("mako").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

    gpu = build.with?("gpu") ? "yes" : "no"
    nogpu = build.with?("gpu") ? "no" : "yes"

    args = %W[
      CFLAGS=#{ENV.cflags}
      CXXFLAGS=#{ENV.cflags}
      --enable-autotools
      --disable-silent-rules
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-opengl
      --enable-llvm
      --disable-llvm-shared-libs
      --enable-shared-glapi
      --with-llvm-prefix=#{Formula["llvm@7"].opt_prefix}
      --enable-dri3=#{gpu}
      --enable-dri=#{gpu}
      --enable-egl=#{gpu}
      --enable-gallium-osmesa=#{nogpu}
      --enable-gallium-tests=#{gpu}
      --enable-gbm=#{gpu}
      --enable-gles1=#{gpu}
      --enable-gles2=#{gpu}
      --enable-glx-tls=#{gpu}
      --enable-glx=#{gpu}
      --enable-osmesa=#{gpu}
      --enable-sysfs=#{gpu}
      --enable-texture-float=#{gpu}
      --enable-va=#{gpu}
      --enable-vdpau=#{gpu}
      --enable-xa=#{gpu}
      --enable-xvmc=#{gpu}
    ]

    if build.with? "gpu"
      args += %W[
        --with-platforms=drm,x11,surfaceless#{build.with?("wayland") ? ",wayland" : ""}
        --with-gallium-drivers=i915,nouveau,r300,r600,radeonsi,svga,swrast,swr
        --with-dri-drivers=i965,nouveau,radeon,r200,swrast
      ]
    else
      args += %w[
        --with-platforms=
        --with-gallium-drivers=swrast,swr
        --with-dri-drivers=
      ]
    end

    # Possible gallium drivers:
    # ddebug,etnaviv,freedreno,i915,imx,llvmpipe,noop,nouveau,pl111,r300,r600,radeon,radeonsi,rbug,softpipe,svga,swr,trace,vc4,virgl

    # enable-opencl => needs libclc
    # enable-gallium-osmesa => mutually exclusive with enable-osmesa

    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"
    args << "--enable-libglvnd" if build.with? "libglvnd"

    inreplace "bin/ltmain.sh", /.*seems to be moved"/, '#\1seems to be moved"'

    system "./autogen.sh", *args
    system "make"
    system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}" if build.with? "gpu"
    system "make", "check" if build.with?("test")
    system "make", "install"
    system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}", "install" if build.with? "gpu"

    if build.with? "libva"
      resource("libva").stage do
        libvaargs = %W[
          --prefix=#{Formula["libva"].opt_prefix}
          --sysconfdir=#{Formula["libva"].opt_prefix}/etc
          --localstatedir=#{Formula["libva"].opt_prefix}/var
          --disable-dependency-tracking
          --disable-silent-rules
          --enable-static=#{build.with?("static") ? "yes" : "no"}
        ]

        ### Set environment flags:
        # $ pkg-config --cflags egl | tr ' ' '\n'
        # $ pkg-config --cflags gl  | tr ' ' '\n'
        ENV["EGL_CFLAGS"] = "-I#{include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libdrm"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libdrm"].opt_include}/libdrm"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libx11"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxau"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxcb"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxdamage"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxdmcp"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxext"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxfixes"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxxf86vm"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xorgproto"].opt_include}"

        ENV["GLX_CFLAGS"] = ENV["EGL_CFLAGS"]

        ENV["EGL_LIBS"] = "-L#{lib} -lEGL"
        ENV["GLX_LIBS"] = "-L#{lib} -lGL"

        system "autoreconf", "-fi" if build.without? "wayland" # needed only if Wayland is not installed
        system "./configure", *libvaargs
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
      libXau.so.6
      libXdmcp.so.6
    ]
    libs << "libexpat.so.1" if build.with?("wayland")

    libs.each do |lib|
      assert_match lib, output
    end
  end
end
