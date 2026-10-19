class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/refs/tags/intel-gmmlib-22.10.2.tar.gz"
  sha256 "94d0038ef92bb65b86d08f004197c56f8d81f82f9ac7a25c202a88afd653a30b"
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
