class Umockdev < Formula
  desc "Mock devices for integration tests for hardware-related libraries"
  homepage "https://launchpad.net/umockdev"
  url "https://github.com/martinpitt/umockdev/releases/download/0.17.15/umockdev-0.17.15.tar.xz"
  sha256 "ed418ee2bbfb0781f4b24b9729ef270ad83cddccd66a59ff944b059ef1368fef"

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
    system "make", "install"

    inreplace bin/"umockdev-wrapper", "LD_PRELOAD=", "LD_PRELOAD=#{opt_lib}/"
    (prefix/"devices").install Dir["devices/*"]
    (prefix/"tests").install Dir["tests/*"].select { |f| Pathname.new(f).elf? && File.executable?(f) }
  end

  test do
    chdir prefix do
      system "#{bin}/umockdev-wrapper", "./tests/test-umockdev-run"
      system "#{bin}/umockdev-wrapper", "./tests/test-ioctl-tree"
      chatter_output = shell_output('printf "%s\n" Homebrew rocks! | ./tests/chatter /dev/stdin')
      assert_match "I \u2665 Homebrew".encode("utf-8"), chatter_output
      system "#{bin}/umockdev-wrapper", "./tests/readbyte", "./NEWS", "open"
      system "#{bin}/umockdev-wrapper", "./tests/readbyte", "./NEWS", "fopen"
      wrapper_output = shell_output("#{bin}/umockdev-wrapper #{bin}/umockdev-run -- head -n 1 /proc/cpuinfo").strip
      assert_equal "processor	: 0", wrapper_output
      cmd = <<~EOS
        #{bin}/umockdev-wrapper #{bin}/umockdev-run -- sh -c 'mkdir $UMOCKDEV_DIR/proc;
        echo HOMEBREW > $UMOCKDEV_DIR/proc/cpuinfo;
        cat /proc/cpuinfo'
      EOS
      assert_equal "HOMEBREW", shell_output(cmd).strip
    end
  end
end
