class Mtdev < Formula
  desc "Multitouch Protocol Translation Library"
  homepage "http://bitmath.org"
  url    "http://bitmath.org/code/mtdev/mtdev-1.1.5.tar.bz2"
  sha256 "6677d5708a7948840de734d8b4675d5980d4561171c5a8e89e54adf7a13eba7f"
  # tag "linuxbrew"

  option "with-static", "Build static libraries (not recommended)"
  depends_on "pkg-config" =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    output = shell_output("ldd #{bin}/mtdev-test").chomp
    assert_match "#{HOMEBREW_PREFIX}/lib/libmtdev.so.1", output
  end
end
