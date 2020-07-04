class LibvdpauVaGl < Formula
  desc "VDPAU driver for hardware that supports VAAPI"
  homepage "https://www.freedesktop.org/wiki/Software/VDPAU/"
  url "https://github.com/i-rinat/libvdpau-va-gl/releases/download/v0.4.2/libvdpau-va-gl-0.4.2.tar.gz"
  sha256 "7d9121540658eb0244859e63da171ca3869e784afbeaf202f44471275c784af4"

  livecheck do
    url "https://github.com/i-rinat/libvdpau-va-gl/releases"
    regex(%r{Latest.*?href="/i-rinat/libvdpau-va-gl/tree/v?([a-z0-9.]+)}m)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "f9dd19e3c9891c6bf27f5a742f717d985e4aafdbcadf9b40d49f70d3a4038c7e" => :x86_64_linux
  end

  # option "without-test", "Skip compile-time tests"

  # Build-time
  depends_on "cmake" => :build
  depends_on "ffmpeg" => :build
  depends_on "glib" => :build
  depends_on "pkg-config" => :build # libswscale

  # Required
  depends_on "linuxbrew/xorg/glu"
  depends_on "linuxbrew/xorg/libice"
  depends_on "linuxbrew/xorg/libva"
  depends_on "linuxbrew/xorg/libvdpau"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << ".."

    (buildpath/"build").mkpath
    cd "build" do
      system "cmake", *args
      system "make"
      # system "make", "check" if build.with?("test") ### currently tests fail with:
      # X11 connection rejected because of wrong authentication
      system "make", "install"
    end
  end
end
