class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/refs/tags/intel-gmmlib-22.10.0.tar.gz"
  sha256 "893e3c5a24b408ac312a0318b70f38f427f297646e323f31e79d3a06a92c1543"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "29e5f6ddbe1c4be1fa15713d808ea5f3f4ced7cb1e164c0c70a030004cb8702d"
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
