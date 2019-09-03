class Umockdev < Formula
  desc "Mock devices for integration tests for hardware-related libraries"
  homepage "https://launchpad.net/umockdev"
  url "https://github.com/martinpitt/umockdev/releases/download/0.13.2/umockdev-0.13.2.tar.xz"
  sha256 "e43c8208de67a35333e344408462d3bf55464df004a8a7092a3a88c1961abb24"

  bottle do
    cellar :any_skip_relocation
    sha256 "73bbf78ed7f5cca0918d7652e2a4e7de6cf743ed1b07806b332bb6488919dbbd" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"

  depends_on "gobject-introspection" => [:recommended, :build]
  depends_on "gphoto2" => [:recommended, :build]
  depends_on "gtk-doc" => [:recommended, :build]
  depends_on "pkg-config" => :build
  depends_on "vala" => [:recommended, :build]
  depends_on "glib"
  depends_on "systemd"

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--enable-gtk-doc" if build.with? "gtk-doc"
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"

    inreplace bin/"umockdev-wrapper", "LD_PRELOAD=", "LD_PRELOAD=#{opt_lib}/"
    (prefix/"devices").install Dir["devices/*"]
    (prefix/"tests").install Dir["tests/*"].select { |f| Pathname.new(f).elf? && File.executable?(f) }
  end

  test do
    chdir prefix do
      system "#{bin}/umockdev-wrapper", "./tests/test-umockdev-run"
      system "#{bin}/umockdev-wrapper", "./tests/test-ioctl-tree"
      assert_match "I \u2665 Homebrew".encode("utf-8"), shell_output('printf "%s\n" Homebrew rocks! | ./tests/chatter /dev/stdin')
      system "#{bin}/umockdev-wrapper", "./tests/readbyte", "./NEWS", "open"
      system "#{bin}/umockdev-wrapper", "./tests/readbyte", "./NEWS", "fopen"
      assert_equal "processor	: 0", shell_output("#{bin}/umockdev-wrapper #{bin}/umockdev-run -- head -n 1 /proc/cpuinfo").strip
      cmd = <<~EOS
        #{bin}/umockdev-wrapper #{bin}/umockdev-run -- sh -c 'mkdir $UMOCKDEV_DIR/proc;
        echo HOMEBREW > $UMOCKDEV_DIR/proc/cpuinfo;
        cat /proc/cpuinfo'
      EOS
      assert_equal "HOMEBREW", shell_output(cmd).strip
    end
  end
end
