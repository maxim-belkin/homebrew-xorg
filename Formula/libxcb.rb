class Libxcb < Formula
  desc "Interface to the X Window System protocol and replacement for Xlib"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://xcb.freedesktop.org/dist/libxcb-1.13.1.tar.bz2"
  sha256 "a89fb7af7a11f43d2ce84a844a4b38df688c092bf4b67683aef179cdf2a647c4"
  revision 1
  # tag "linuxbrew"

  livecheck do
    url "https://ftp.x.org/archive/individual/lib/"
    regex(/libxcb-([0-9.]+)\.tar.gz/)
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "71e21416bda37d0b5468451eb73b65abf3edce3ced56f12c4da45412ce2c5f36" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-devel-docs", "Build developer documentation"

  depends_on "linuxbrew/xorg/xcb-proto" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.8" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" # xcb.pc references pthread-stubs
  depends_on "linuxbrew/xorg/libxau"
  depends_on "linuxbrew/xorg/libxdmcp"

  if build.with? "devel-docs"
    depends_on "doxygen" => :build
    depends_on "graphviz" => :build
  end

  if build.with? "test"
    depends_on "check" => :build
    depends_on "libxslt" => [:build, :recommended]
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-dri3
      --enable-ge
      --enable-xevie
      --enable-xprint
      --enable-selinux
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-devel-docs=#{build.with?("devel-docs") ? "yes" : "no"}
      --with-doxygen=#{build.with?("devel-docs") ? "yes" : "no"}
    ]

    ENV["DOT"] = Formula["graphviz"].opt_bin if build.with? "devel-docs"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <stdlib.h>
      #include "xcb/xcb.h"

      int main() {
        xcb_connection_t    *c;
        xcb_screen_t        *screen;
        const xcb_setup_t   *setup;
        int                  screen_nbr;
        xcb_window_t         win;

        /* Open the connection to the X server */
        c = xcb_connect (NULL, &screen_nbr);
        int err = xcb_connection_has_error(c);
        if (err > 0)
          return 1;
        /* Get the first screen */
        setup = xcb_get_setup(c);
        screen = xcb_setup_roots_iterator(setup).data;
        /* Request an ID for our window */
        win = xcb_generate_id (c);
        /* Create the window */
        xcb_create_window (c, XCB_COPY_FROM_PARENT, win, screen->root, 0, 0,
                           150, 150, 10, XCB_WINDOW_CLASS_INPUT_OUTPUT,
                           screen->root_visual, 0, NULL);
        /* Map the window onto the screen */
        xcb_map_window (c, win);
        /* Show the window */
        xcb_flush (c);
        // Print basic information about the screen
        printf ("Screen %u:\\n", screen_nbr);
        printf ("  width:   %d\\n", screen->width_in_pixels);
        printf ("  height:  %d\\n", screen->height_in_pixels);

        xcb_disconnect (c);

        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test", "-I#{include}", "-L#{lib}", "-lxcb"
    system "./test"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
