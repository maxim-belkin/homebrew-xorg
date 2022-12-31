class Pciutils < Formula
  desc "Programs for inspecting and manipulating configuration of PCI devices"
  homepage "https://www.x.org/"
  url "https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.9.0.tar.xz"
  sha256 "cdea7ae97239dee23249a09c68a19a287a3f109fbeb2c232ebb616cb38599012"

  livecheck do
    url "https://www.kernel.org/pub/software/utils/pciutils/"
    regex(/href=.*?pciutils[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 x86_64_linux: "1444ddc54af53c94e681594d3a48a3da485443a80168c48d75e93272cf5deac7"
  end

  depends_on "pkg-config" => :build

  def install
    args = %W[
      PREFIX=#{prefix}
      SHAREDIR=#{share}
      MANDIR=#{man}
      SHARED=yes
      ZLIB=no
    ]

    system "make", *args
    system "make", *args, "install", "install-lib"
  end

  def post_install
    system "#{sbin}/update-pciids"
  end

  test do
    output = shell_output("#{sbin}/lspci --version").chomp
    assert_equal output, "lspci version #{version}"
  end
end
