class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-19.3.2.tar.gz"
  sha256 "719b6db3052355830b50fb264fe9e2ff889e537375e876d1c5b8410c8561a718"

  bottle do
    cellar :any_skip_relocation
    sha256 "a458f170aeeb2264ac251e15bdbdc6691a4ec317ae73f241ce39966af5724915" => :x86_64_linux
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
