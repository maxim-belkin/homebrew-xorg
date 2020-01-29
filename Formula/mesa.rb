class Mesa < Formula
  include Language::Python::Virtualenv
  desc "Cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://mesa.freedesktop.org/archive/mesa-19.3.3.tar.xz"
  sha256 "81ce4810bb25d61300f8104856461f4d49cf7cb794aa70cb572312e370c39f09"
  head "https://gitlab.freedesktop.org/mesa/mesa.git"

  bottle do
    sha256 "6467c20d2e32157fb4fb66c8a19138cfc13090d73aa102b460ed7cadfadfb475" => :x86_64_linux
  end

  option "without-gpu", "Build without graphics hardware"
  option "without-gl", "Don't build EGL, GL, and GLES libs"

  unless build.without? "gl"
    conflicts_with "linuxbrew/xorg/libglvnd",
      :because => <<~EOS
        both install EGL, GL, and GLES libraries.
        You can either
         - unlink or uninstall libglvnd, or
         - build linuxbrew/xorg/mesa with '--without-gl' option
      EOS
  end

  depends_on "bison" => :build
  depends_on "flex" => :build
  depends_on "gettext" => :build
  depends_on "llvm" => :build
  depends_on "meson-internal" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build

  depends_on "expat" # Indirect linkage
  depends_on "libelf" # Indirect linkage
  depends_on "linuxbrew/xorg/libdrm"
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
  depends_on "lm-sensors" # Optional
  depends_on "ncurses" # Indirect linkage
  depends_on "zlib" # Indirect linkage

  resource "mako" do
    url "https://files.pythonhosted.org/packages/28/03/329b21f00243fc2d3815399413845dbbfb0745cff38a29d3597e97f8be58/Mako-1.1.1.tar.gz"
    sha256 "2984a6733e1d472796ceef37ad48c26f4a984bb18119bb2dbc37a44d8f6e75a4"
  end

  resource "libva" do
    url "https://github.com/intel/libva/releases/download/2.6.1/libva-2.6.1.tar.bz2"
    sha256 "6c57eb642d828af2411aa38f55dc10111e8c98976dbab8fd62e48629401eaea5"
  end

  patch :p1 do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/Patches/mesa-add_xdemos-1.patch"
    sha256 "f7fcde1ca64e5be6a1abc73851e0d156cc227328c58cd9cbac47963e5b9631ad"
  end

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j2" if ENV["CIRCLECI"]

    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python3.7/site-packages"

    resource("mako").stage do
      system "python3", *Language::Python.setup_install_args(libexec/"vendor")
    end

    if build.with?("gpu")
      gpu = "true"
      gl = build.with?("gl") ? "true" : "false"
      platforms = %w[x11 wayland drm surfaceless].join(",")
      dri_drivers = build.with?("gl") ? "auto" : ""
      gallium_drivers = "auto"
      glx = build.with?("gl") ? "auto" : "disabled"
      tools = "drm-shim,etnaviv,freedreno,glsl,nir,nouveau,xvmc,lima"
      # 'intel' tool requires libepoxy, which depends on mesa. circular dependency.
    else
      gpu = "false"
      gl = "false"
      platforms = ""
      dri_drivers = ""
      gallium_drivers = ""
      glx = "disabled"
      tools = ""
    end

    args = %W[
      -Dprefix=#{prefix}
      -Dsysconfdir=#{etc}
      -Dlocalstatedir=#{var}
      -Dllvm=true
      -Dshared-llvm=false
      -Dplatforms=#{platforms}
      -Ddri3=#{gpu}
      -Ddri-drivers=#{dri_drivers}
      -Dgallium-drivers=#{gallium_drivers}
      -Degl=#{gl}
      -Dosmesa=none
      -Dgbm=#{gpu}
      -Dopengl=#{gl}
      -Dgles1=#{gl}
      -Dgles2=#{gl}
      -Dglx=#{glx}
      -Dxvmc=#{gpu}
      -Dtools=#{tools}
    ]
    # -Dglvnd=true # fails to build (after some time)
    # -Dvulkan-overlay-layer=true # fails to build (quickly)

    ENV.append "PKG_CONFIG_PATH", Formula["libva-internal"].opt_lib/"pkgconfig"

    mkdir "build" do
      system "meson", *args
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
