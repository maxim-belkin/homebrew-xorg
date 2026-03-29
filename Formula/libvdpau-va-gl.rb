class LibvdpauVaGl < Formula
  desc "VDPAU driver for hardware that supports VAAPI"
  homepage "https://www.freedesktop.org/wiki/Software/VDPAU/"
  url "https://github.com/i-rinat/libvdpau-va-gl/releases/download/v0.4.2/libvdpau-va-gl-0.4.2.tar.gz"
  sha256 "7d9121540658eb0244859e63da171ca3869e784afbeaf202f44471275c784af4"
  revision 2
  license "LGPL-3.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Build-time
  depends_on "cmake" => :build
  depends_on "ffmpeg" => :build
  depends_on "glib" => :build
  depends_on "pkg-config" => :build # libswscale

  # Required
  depends_on "libice"
  depends_on "libva"
  depends_on "libvdpau"
  depends_on "mesa-glu"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
