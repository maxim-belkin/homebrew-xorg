class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-19.3.4.tar.gz"
  sha256 "5f08e36892db6bff8284913d9ab784f693d50e4ea1eb2ea6d2545e3dc6876b71"

  bottle do
    cellar :any_skip_relocation
    sha256 "ae319a5015232afd4744fb9cd7b0c4ae1a3cdb00b34e41816ba61729ab4651ed" => :x86_64_linux
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
