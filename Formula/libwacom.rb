class Libwacom < Formula
  desc "Library to identify wacom tablets and their model-specific features"
  homepage "https://github.com/linuxwacom/libwacom"
  url "https://github.com/linuxwacom/libwacom/releases/download/libwacom-2.18.0/libwacom-2.18.0.tar.xz"
  sha256 "7dbb9ab37df9df47ae2fdbb644916c986728291749bcd5ad8bcaa26f1e15f002"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
    regex(/^libwacom[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "libxml2" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gtk+"
  depends_on "librsvg"
  depends_on "maxim-belkin/xorg/libgudev"

  def install
    system "./configure",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    (prefix/"test").install "test-driver"
    (prefix/"test/tests").install Dir["test/*"].select { |f| Pathname.new(f).elf? && File.executable?(f) }
  end

  test do
    Dir.chdir prefix/"test"
    Dir["tests/*"].each do |t|
      name = File.basename(t)
      system "bash", "test-driver", "--test-name", name,
             "--log-file", testpath/"#{name}.log",
             "--trs-file", testpath/"#{name}.trs", t
    end
  end
end
