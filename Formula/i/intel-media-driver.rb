class IntelMediaDriver < Formula
  desc "Media driver for VAAPI"
  homepage "https://github.com/intel/media-driver"
  url "https://github.com/intel/media-driver/archive/refs/tags/intel-media-26.3.5.tar.gz"
  sha256 "76f41c06cefc91d57e0b7d366b7a91b8420ec77939326491795f9fb26afca7e7"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
    regex(/^intel-media[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "43ca4add4b4e86f686d74659542c26a55131129027dd8dba4be622e4a080319e"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libva"
  depends_on "maxim-belkin/xorg/intel-gmmlib"

  def install
    # Fix cmake_minimum_required(<3.5) rejected by CMake >= 3.30
    %w[
      os_release_info.cmake
      cmrtlib/CMakeLists.txt
      cmrtlib/linux/CMakeLists.txt
      Tools/MediaDriverTools/GenDmyHex/CMakeLists.txt
      Tools/MediaDriverTools/GenKrnBin/CMakeLists.txt
      Tools/MediaDriverTools/KernelBinToSource/CMakeLists.txt
      Tools/MediaDriverTools/KrnToHex/CMakeLists.txt
      Tools/MediaDriverTools/KrnToHex_IGA/CMakeLists.txt
    ].each do |f|
      inreplace f, /cmake_minimum_required\s*\(VERSION \d+\.\d+(\.\d+)?\)/,
                "cmake_minimum_required(VERSION 3.5)"
    end

    args = std_cmake_args + %W[
      -DBUILD_TYPE=Release
      -DUFO_MARCH=x86_64
      -DLIBVA_DRIVERS_PATH=#{lib}/dri
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_path_exists lib/"dri/iHD_drv_video.so"
  end
end
