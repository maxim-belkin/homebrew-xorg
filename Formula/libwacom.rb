class Libwacom < Formula
  desc "Library to identify wacom tablets and their model-specific features"
  homepage "https://github.com/linuxwacom/libwacom"
  url "https://github.com/linuxwacom/libwacom/releases/download/libwacom-1.2/libwacom-1.2.tar.bz2"
  sha256 "c204cfdee2159d124a4f5ecc8970bbd72f9adf5ad7fd94b66798f93db1f863c3"

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/(?:libwacom[._-])?v?(\d+(?:\.\d+)+)["' >]}i)
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
