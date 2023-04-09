class Xrdb < Formula
  desc "X.Org Applications: xrdb"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrdb-1.2.1.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xrdb-1.2.1.tar.bz2"
  sha256 "4f5d031c214ffb88a42ae7528492abde1178f5146351ceb3c05f3b8d5abee8b4"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "gcc"
  depends_on "libxmu"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-cpp=#{Formula["gcc"].opt_bin}/cpp
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"xversion").write <<~EOF
      Version: VERSION
    EOF
    cmd = "xrdb -global -n xversion"
    assert_match "Version:\t11", shell_output(cmd).chomp
  end
end
