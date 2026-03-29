class IntelMediaDriver < Formula
  desc "Media driver for VAAPI"
  homepage "https://github.com/intel/media-driver"
  url "https://github.com/intel/media-driver/archive/refs/tags/intel-media-25.4.6.tar.gz"
  sha256 "e5cf57c66e22359d1ec07d766b04e5da43677b9330999ce0dbf686aac60cf6bb"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
    regex(/^intel-media[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f281f0f157c8de3dd0a546c348191ff69505985a7517c2732ef22dfe4c61fd69"
  end

  depends_on "cmake" => :build
  depends_on "maxim-belkin/xorg/intel-gmmlib" => :build
  depends_on "pkg-config" => :build
  depends_on "libva"

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

    args = std_cmake_args + %w[
      -DBUILD_TYPE=Release
      -DUFO_MARCH=x86_64
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate lib, :directory?
  end
end
