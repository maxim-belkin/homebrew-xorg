class IntelMediaDriver < Formula
  desc "Media driver for VAAPI"
  homepage "https://github.com/intel/media-driver"
  url "https://github.com/intel/media-driver/archive/intel-media-19.4.0r.tar.gz"
  sha256 "a03bd75eefe9cb0245e3aab2723b3fef555d9f180a180b2c29d7b12d483d9ec2"

  livecheck do
    url "https://github.com/intel/media-driver/releases"
    regex(%r{latest.*?href="/intel/media-driver/archive/intel-media-?([a-z0-9.]+)\.t}mi)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "27e721bb9b49179017e50998da0847a72658452870964963aab109e2c58fd2d7" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "linuxbrew/xorg/intel-gmmlib" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libva"

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
