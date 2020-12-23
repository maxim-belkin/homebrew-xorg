class IntelMediaDriver < Formula
  desc "Media driver for VAAPI"
  homepage "https://github.com/intel/media-driver"
  url "https://github.com/intel/media-driver/archive/intel-media-19.4.0r.tar.gz"
  sha256 "a03bd75eefe9cb0245e3aab2723b3fef555d9f180a180b2c29d7b12d483d9ec2"
  revision 1

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/intel-media[._-]v?([^"' >]+)["' >]}i)
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "dd8ac08582837225827f555656505dd49321ec20c6b43b2a984e8e362d8a745a" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "linuxbrew/xorg/intel-gmmlib" => :build
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
