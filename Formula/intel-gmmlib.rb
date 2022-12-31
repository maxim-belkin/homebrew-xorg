class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-22.3.2.tar.gz"
  sha256 "f725fbb4291ab67bbc7b31e1a268f523df384667360c931b40144db861be53d7"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "22c7c306d62be717fbf04bcea74cf84a5908c55246a58e668a4b5a450d7f2cd7"
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
