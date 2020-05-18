class Libgudev < Formula
  desc "Library providing GObject bindings for libudev"
  homepage "https://wiki.gnome.org/Projects/libgudev"
  url "https://download.gnome.org/sources/libgudev/233/libgudev-233.tar.xz"
  sha256 "587c4970eb23f4e2deee2cb1fb7838c94a78c578f41ce12cac0a3f4a80dabb03"

  bottle do
    cellar :any_skip_relocation
    sha256 "04f5bb2fd056fecf62ad422abfd194ad9d3c017faa512d9b3d296f986fc21869" => :x86_64_linux
  end

  depends_on "gobject-introspection" => [:recommended, :build]
  depends_on "gtk-doc" => [:recommended, :build]
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "linuxbrew/xorg/umockdev"
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
