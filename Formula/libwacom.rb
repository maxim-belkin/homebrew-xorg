class Libwacom < Formula
  desc "Library to identify wacom tablets and their model-specific features"
  homepage "https://github.com/linuxwacom/libwacom"
  url "https://github.com/linuxwacom/libwacom/releases/download/libwacom-1.0/libwacom-1.0.tar.bz2"
  sha256 "c48f931bcebaa87ae38e3c3a14863d507cd083313207802864ab2763c5b90cc7"

  bottle do
    sha256 "a911e71045926e0765f4f9bc394f4907f80b11e2fdf5468f4a61fdba86004231" => :x86_64_linux
  end

  depends_on "libxml2" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gtk+"
  depends_on "librsvg"
  depends_on "linuxbrew/xorg/libgudev"

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
      system("bash", "test-driver", "--test-name", name, "--log-file", testpath/"#{name}.log", "--trs-file", testpath/"#{name}.trs", t)
    end
  end
end
