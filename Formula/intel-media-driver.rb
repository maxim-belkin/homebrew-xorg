class IntelMediaDriver < Formula
  desc "Media driver for VAAPI"
  homepage "https://github.com/intel/media-driver"
  url "https://github.com/intel/media-driver/archive/intel-media-19.4.0r.tar.gz"
  sha256 "a03bd75eefe9cb0245e3aab2723b3fef555d9f180a180b2c29d7b12d483d9ec2"
  revision 1

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/intel-media[._-]v?([^"' >&]+)["' >]}i)
  end

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/intel-media-driver-19.4.0r_1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fd27df68c74430855e469fb6f6c4bf9fe74ea2dd9fc0b615806497607b0151c8"
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
