class Mesa < Formula
  include Language::Python::Virtualenv
  desc "Cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://mesa.freedesktop.org/archive/mesa-19.1.6.tar.xz"
  sha256 "2a369b7b48545c6486e7e44913ad022daca097c8bd937bf30dcf3f17a94d3496"
  head "https://gitlab.freedesktop.org/mesa/mesa.git"

  bottle do
    sha256 "36731aa03379dd53735bdd58bd5c53e1f1fbec26b4f020f215bf8a4ec0428507" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "without-gpu", "Build without graphics hardware"

  # Build-time dependencies
  depends_on "bison" => :build
  depends_on "flex" => :build
  depends_on "gettext" => :build
  depends_on "llvm@7" => :build
  depends_on "meson-internal" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build

  # Dependencies from linuxbrew/core
  depends_on "expat" # Indirect linkage
  depends_on "libelf" # Indirect linkage
  depends_on "lm-sensors" # Optional
  depends_on "ncurses" # Indirect linkage
  depends_on "zlib" # Indirect linkage

  # Dependencies from linuxbrew/xorg
  depends_on "linuxbrew/xorg/libomxil-bellagio" # Optional
  depends_on "linuxbrew/xorg/libva-internal" # Optional
  depends_on "linuxbrew/xorg/libvdpau" # Optional. No linkage
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxcb" # Indirect linkage
  depends_on "linuxbrew/xorg/libxdamage"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxfixes" # Indirect linkage
  depends_on "linuxbrew/xorg/libxrandr" # No linkage
  depends_on "linuxbrew/xorg/libxshmfence"
  depends_on "linuxbrew/xorg/libxv" # Indirect linkage
  depends_on "linuxbrew/xorg/libxvmc" # Optional
  depends_on "linuxbrew/xorg/libxxf86vm"
  depends_on "linuxbrew/xorg/wayland"
  depends_on "linuxbrew/xorg/wayland-protocols" # No linkage

  # depends_on "linuxbrew/xorg/libunwind" # Optiona. Breaks linkage (09/18/19).
  # depends_on "systemd" # provides libudev which is needed by "gbm"
  
  resource "mako" do
    url "https://files.pythonhosted.org/packages/b0/3c/8dcd6883d009f7cae0f3157fb53e9afb05a0d3d33b3db1268ec2e6f4a56b/Mako-1.1.0.tar.gz"
    sha256 "a36919599a9b7dc5d86a7a8988f23a9a3a3d083070023bab23d64f7f1d1e0a4b"
  end

  resource "libva" do
    url "https://github.com/intel/libva/releases/download/2.5.0/libva-2.5.0.tar.bz2"
    sha256 "3aa89cd369a506ac4dbe5de7c0ef5da4f3d220bf986403f02fa1f6f702af6878"
  end

  patch :p1 do
    url "www.linuxfromscratch.org/patches/blfs/svn/mesa-19.1.6-add_xdemos-1.patch"
    sha256 "ffa885d37557feaacabd5852d5aa8d17e15eb6a41456bb6f9525d52a96e86601"
  end

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j2" if ENV["CIRCLECI"]

    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python3.7/site-packages"

    resource("mako").stage do
      system "python3", *Language::Python.setup_install_args(libexec/"vendor")
    end

    gpu = build.with?("gpu") ? "yes" : "no"
    nogpu = build.with?("gpu") ? "no" : "yes"

    args = %W[
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


    ENV.append "PKG_CONFIG_PATH", Formula["libva-internal"].opt_lib/"pkgconfig"

    mkdir "build" do
      system "meson",
        "-Dprefix=#{prefix}",
        "-Dsysconfdir=#{etc}",
        "-Dlocalstatedir=#{var}",
        "-Dshared-llvm=false"
        #"-Dglvnd=true" # fails to build (after some time)
        # "-Dvulkan-overlay-layer=true" # fails to build (quickly)
      system "ninja"
      system "ninja", "install"
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
