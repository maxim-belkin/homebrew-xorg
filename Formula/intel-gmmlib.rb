class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-19.4.1.tar.gz"
  sha256 "bb874b41c499abb8f6253b1834e93a02ed9744de71f2503ee9cd4100af7c1860"

  bottle do
    cellar :any_skip_relocation
    sha256 "3975c50c6048193d04d215e930ce4384b85b23d10e8e63f914a15e7b588703a6" => :x86_64_linux
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
