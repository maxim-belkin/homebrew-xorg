class Pciutils < Formula
  desc "Programs for inspecting and manipulating configuration of PCI devices"
  homepage "https://www.x.org/"
  url "https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.5.1.tar.xz"
  sha256 "2bf3a4605a562fb6b8b7673bff85a474a5cf383ed7e4bd8886b4f0939013d42f"
  # tag "linuxbrew"

  livecheck do
    url "https://www.kernel.org/pub/software/utils/pciutils/"
    regex(/href=.*?pciutils[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 "a824aca17f0b34dcc21ea46674213d0a71d213e2bb69e7314f8d8113468cb649" => :x86_64_linux
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
