class Libsm < Formula
  desc "X.Org Libraries: libSM"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libSM-1.2.3.tar.bz2"
  sha256 "2d264499dcb05f56438dee12a1b4b71d76736ce7ba7aa6efbf15ebb113769cbb"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "c545076505335487a8e96a628c41fa57674135b321eee6aadb7fcf564d649fb8" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-docs", "Build documentation"

  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "linuxbrew/xorg/xtrans" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libice"

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/0b466fe45991ae0f8b11a68d8fd0bf48198fc395/Patches/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with? "docs"
    depends_on "xmlto" => :build
    depends_on "fop"     => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "linuxbrew/xorg/xorg-sgml-doctools" => [:build, :recommended]
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-docs=#{build.with?("docs") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <dlfcn.h>
      #include <stdio.h>
      #include <assert.h>
      #include "X11/SM/SMlib.h"

      int main(int argc, char* argv[]) {
        // Make sure we can load the library
        void *handle;
        handle = dlopen("#{lib}/libSM.so", RTLD_LAZY);
        if (!handle) {
          fputs(dlerror(), stderr);
          return 1;
        }

        // Function pointer
        static int (*lib_func) () = NULL;

        // Make sure 'SmsInitialize' symbol exists in the library
        lib_func = dlsym(handle, "SmsInitialize");
        char *error;
        if ((error = dlerror()) != NULL) {
          fputs(error, stderr);
          return 1;
        }

        // Prepare some variables
        SmsNewClientProc newClientProc;
        IceHostBasedAuthProc hostBasedAuthProc;
        SmPointer managerData;
        int errorLength;
        char * err;

        // Call 'SmsInitialize' using the extracted symbol and directly
        int status1 = lib_func("vendor", "release", newClientProc, managerData, hostBasedAuthProc, errorLength, err);
        int status2 = SmsInitialize("vendor", "release", newClientProc, managerData, hostBasedAuthProc, errorLength, err);

        assert(status1==status2);

        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test", "-ldl", "-I#{include}", "-L#{lib}", "-lSM"
    system "./test"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
