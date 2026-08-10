class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/refs/tags/intel-gmmlib-22.10.1.tar.gz"
  sha256 "33ebb6e65a2617c59f95a9e70ce0cbeca098316cd265345a0f4db5b381f1024c"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "5eff9970f5a69c78e110ba67f83847cfbb09dc1f1e7a5b63d9a3754287737309"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DBUILD_TYPE=release"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_path_exists lib/"libigdgmm.so"
  end
end
