class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-19.4.1.tar.gz"
  sha256 "bb874b41c499abb8f6253b1834e93a02ed9744de71f2503ee9cd4100af7c1860"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "02c15ec899163d0e0ff91fe12482ac2268cf736f69c10a70c9b4649e56cd4d76"
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
