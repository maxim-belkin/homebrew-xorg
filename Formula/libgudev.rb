class Libgudev < Formula
  desc "Library providing GObject bindings for libudev"
  homepage "https://wiki.gnome.org/Projects/libgudev"
  url "https://download.gnome.org/sources/libgudev/232/libgudev-232.tar.xz"
  sha256 "ee4cb2b9c573cdf354f6ed744f01b111d4b5bed3503ffa956cefff50489c7860"

  depends_on "gobject-introspection" => [:recommended, :build]
  depends_on "gtk-doc" => [:recommended, :build]
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "linuxbrew/xorg/umockdev"
  depends_on "systemd"

  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=880332
  patch :DATA

  def install
    ENV.deparallelize
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
    inreplace "tests/Makefile",
      "env LD_PRELOAD=libumockdev-preload.so.0: gtester",
      "env LD_PRELOAD=#{Formula["linuxbrew/xorg/umockdev"].opt_lib}/libumockdev-preload.so.0 gtester"
    system "make"
    system "make", "check"
    chmod 0644, "./docs/html/style.css"
    system "make", "install"

    (prefix/"tests").install Dir["tests/.libs/*"]
  end

  test do
    Dir[prefix/"tests/*"].each do |f|
      system "#{Formula["umockdev"].opt_bin}/umockdev-wrapper", f
    end
  end
end
__END__
diff --git a/tests/test-enumerator-filter.c b/tests/test-enumerator-filter.c
index 9c97903..dfcdba2 100644
--- a/tests/test-enumerator-filter.c
+++ b/tests/test-enumerator-filter.c
@@ -37,6 +37,9 @@ test_enumerator_filter (void)
 	/* create test bed */
 	UMockdevTestbed *testbed = umockdev_testbed_new ();

+	/* Relies on a test bed having been set up */
+	g_assert (umockdev_in_mock_environment ());
+
 	/* Add 2 devices in the USB subsystem, and one in the DRM subsystem */
 	umockdev_testbed_add_device (testbed, "usb", "dev1", NULL,
 				     "idVendor", "0815", "idProduct", "AFFE", NULL,
@@ -74,8 +77,6 @@ int main(int argc, char **argv)
 	setlocale (LC_ALL, NULL);
 	g_test_init (&argc, &argv, NULL);

-	g_assert (umockdev_in_mock_environment ());
-
 	g_test_add_func ("/gudev/enumerator_filter", test_enumerator_filter);

 	return g_test_run ();

