class Mesa < Formula
  include Language::Python::Virtualenv
  desc "Cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://mesa.freedesktop.org/archive/mesa-19.1.2.tar.xz"
  sha256 "813a144ea8ebefb7b48b6733f3f603855b0f61268d86cc1cc26a6b4be908fcfd"
  head "https://gitlab.freedesktop.org/mesa/mesa.git"

  bottle do
    sha256 "36731aa03379dd53735bdd58bd5c53e1f1fbec26b4f020f215bf8a4ec0428507" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "without-gpu", "Build without graphics hardware"

  depends_on "bison" => :build
  depends_on "flex" => :build
  depends_on "gettext" => :build
  depends_on "libtool" => :build
  depends_on "linuxbrew/xorg/libxrandr" => :build
  depends_on "linuxbrew/xorg/wayland-protocols" => :build
  depends_on "llvm@7" => :build
  depends_on "meson-internal" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build # see docs/install.html
  depends_on "expat" # see docs/install.html
  depends_on "libelf"
  depends_on "linuxbrew/xorg/libdrm"
  depends_on "linuxbrew/xorg/libomxil-bellagio"
  # depends_on "linuxbrew/xorg/libpthread-stubs" => :build
  # depends_on "linuxbrew/xorg/libvdpau" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxcb"
  depends_on "linuxbrew/xorg/libxdamage"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxfixes"
  depends_on "linuxbrew/xorg/libxshmfence"
  depends_on "linuxbrew/xorg/libxxf86vm"
  depends_on "linuxbrew/xorg/wayland"
  # depends_on "linuxbrew/xorg/xorgproto" => :build
  # depends_on "linuxbrew/xorg/libxv"
  # depends_on "linuxbrew/xorg/libxvmc" # b.c. reported by linkage # b.c. reported by linkage # b.c. reported by linkage # b.c. reported by linkage
  depends_on "ncurses" # b.c. reported by linkage
  depends_on "zlib" # b.c. reported by linkage
  # depends_on "systemd" # provides libudev <= needed by "gbm" # failed with llvm@6 # radeonsi requires libelf when using llvm
  # depends_on "linuxbrew/xorg/libva"
  # depends_on "valgrind" => :recommended
  # depends_on "linuxbrew/xorg/libglvnd" => :optional

  #
  # There is a circular dependency between Mesa and libva:
  # libva should be installed:
  #  1. before Mesa with "disable-egl" and "disable-egl" options  [libva formula]
  #  2. after  Mesa without the above two options                 [this formula]
  #

  resource "mako" do
    url "https://files.pythonhosted.org/packages/fa/29/8016763284d8fab844224f7cc5675cb4a388ebda0eb5a403260187e48435/Mako-1.0.13.tar.gz"
    sha256 "95ee720cc3453063788515d55bd7ce4a2a77b7b209e4ac70ec5c86091eb02541"
  end

  resource "gears.c" do
    url "https://www.opengl.org/archives/resources/code/samples/glut_examples/mesademos/gears.c"
    sha256 "7df9d8cda1af9d0a1f64cc028df7556705d98471fdf3d0830282d4dcfb7a78cc"
  end

  resource "libva" do
    url "https://github.com/intel/libva/releases/download/2.5.0/libva-2.5.0.tar.bz2"
    sha256 "3aa89cd369a506ac4dbe5de7c0ef5da4f3d220bf986403f02fa1f6f702af6878"
  end

  # patch :p1 do
  #   url "http://www.linuxfromscratch.org/patches/blfs/svn/mesa-19.1.2-add_xdemos-1.patch"
  #   sha256 "ffa885d37557feaacabd5852d5aa8d17e15eb6a41456bb6f9525d52a96e86601"
  # end

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j2" if ENV["CIRCLECI"]

    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python3.7/site-packages"

    resource("mako").stage do
      system "python3", *Language::Python.setup_install_args(libexec/"vendor")
    end

    # resource("gears.c").stage(pkgshare.to_s) 

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

    # inreplace "bin/ltmain.sh", /.*seems to be moved"/, '#\1seems to be moved"'

    ENV["PKG_CONFIG_PATH"] = Formula["pkg-config"].opt_prefix/"bin/pkg-config"
    mkdir "build" do
      system "meson",
        "--prefix=#{prefix}",
        "-Dshared-llvm=false",
        "-Dc_link_args='-Wl,-rpath,#{HOMEBREW_PREFIX.to_s}/lib'"
      #, "-D buildtype=plain", "-D b_ndebug=true", ".."
      system "ninja"
      system "ninja", "install"
    end

    # system "./autogen.sh", *args
    # system "make"
    # system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}" if build.with? "gpu"
    # system "make", "check" if build.with?("test")
    # system "make", "install"
    # system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}", "install" if build.with? "gpu"

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
