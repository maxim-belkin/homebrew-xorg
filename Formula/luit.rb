class Luit < Formula
  desc "X.Org Applications: luit"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/luit-1.1.1.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/luit-1.1.1.tar.bz2"
  sha256 "30b0e787cb07a0f504b70f1d6123930522111ce9d4276f6683a69b322b49c636"
  revision 1
  # tag "linuxbrew"

  bottle do
  end

  depends_on "libx11" => :build
  depends_on "pkg-config" => :build
  depends_on "libfontenc"

  patch :DATA

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-localealiasfile=#{Formula["libx11"].share}/X11/locale/locale.alias
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
__END__
diff --git a/sys.c b/sys.c
index 8463b05..70c8f8b 100644
--- a/sys.c
+++ b/sys.c
@@ -20,6 +20,11 @@ OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
 
+#ifdef _XOPEN_SOURCE
+#  undef _XOPEN_SOURCE
+#  define _XOPEN_SOURCE 600
+#endif
+
 #ifdef HAVE_CONFIG_H
 # include "config.h"
 #endif
