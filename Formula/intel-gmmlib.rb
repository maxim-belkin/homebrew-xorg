class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-19.3.3.tar.gz"
  sha256 "aceb11fd61a895e30fc67c8a6230ffe8b44b2336fc2a81f5408b1b1a535763f5"

  bottle do
    cellar :any_skip_relocation
    sha256 "c3e37e025d3bd301abae8e04915b385b5dc1d14fd2f9a1a5d1e9df84039daf6c" => :x86_64_linux
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DBUILD_TYPE=release"
      system "make"
      system "make", "install"
    end
  end
end
