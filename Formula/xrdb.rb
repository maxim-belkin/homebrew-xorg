class Xrdb < Formula
  desc "X.Org Applications: xrdb"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrdb-1.2.0.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xrdb-1.2.0.tar.bz2"
  sha256 "f23a65cfa1f7126040d68b6cf1e4567523edac10f8dc06f23d840d330c7c6946"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "a4fdfc3af56a2d0ba90dc60458de4fe296dc296ec000214165203d41990dad4a" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build
  depends_on "gcc"
  depends_on "linuxbrew/xorg/libxmu"

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
