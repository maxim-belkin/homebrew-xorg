class Libsha1 < Formula
  desc "Tiny library providing SHA1 implementation"
  homepage "https://raw.githubusercontent.com/dottedmag/libsha1/master/README"
  url "https://github.com/dottedmag/libsha1.git"
  version "0.3"

  bottle do
    cellar :any
    sha256 "3ff1d504fc8fd266bf7d7e4c67c2afd0bb56e8e2525507d9e2a69a6e76e8c714" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-shared=yes
    ]

    system "autoreconf", "-fiv"
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <string.h>
      #include <libsha1.h>

      int main(int argc, char** argv)
      {
        const unsigned char* myMsg = "Hello Homebrew";
        unsigned char hash[20];
        sha1(hash, myMsg, strlen(myMsg));
        for(int i = 0; i < 20; i++)
        {
          printf("%02x", hash[i]);
        }
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lsha1", "-o", "test"
    output = shell_output("./test").chomp
    assert_match "9a66017dd5541865f931722de8df111c501c993d", output
  end
end
