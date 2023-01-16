class IntelMediaDriver < Formula
  desc "Media driver for VAAPI"
  homepage "https://github.com/intel/media-driver"
  url "https://github.com/intel/media-driver/archive/intel-media-22.6.6.tar.gz"
  sha256 "b553290e829dfd824eb62295c9f07dbe8062ce7998f7c527cc92856d0792562d"

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/intel-media[._-]v?([^"' >&]+)["' >]}i)
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b89a451276ddbccbaa55ca8258650e5f67b0a7bdbf6414cc955121a24ac0acc5"
  end

  depends_on "cmake" => :build
  depends_on "maxim-belkin/xorg/intel-gmmlib" => :build
  depends_on "pkg-config" => :build
  depends_on "libva"

  def install
    args = std_cmake_args + %w[
      -DBUILD_TYPE=Release
      -DUFO_MARCH=x86_64
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end
end
