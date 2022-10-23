class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-19.4.1.tar.gz"
  sha256 "bb874b41c499abb8f6253b1834e93a02ed9744de71f2503ee9cd4100af7c1860"

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/intel-gmmlib-19.4.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "98cac6d74328187a45ef0924e4d5854b9592a6f148b0ba785cb5879a0ab1152e"
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
