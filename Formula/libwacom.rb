class Libwacom < Formula
  desc "Library to identify wacom tablets and their model-specific features"
  homepage "https://github.com/linuxwacom/libwacom"
  url "https://github.com/linuxwacom/libwacom/releases/download/libwacom-1.1/libwacom-1.1.tar.bz2"
  sha256 "8cb483593676332e92d3fe1fe816350f136bb906fcee329579d6cb9802d99e02"

  bottle do
    sha256 "9fab5f5c7efa6249c9b5475539fe86fbea04ebde75f1b190f50c7ad439bb5b22" => :x86_64_linux
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
