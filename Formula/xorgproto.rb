class Xorgproto < Formula
  desc "X.Org Protocol Headers"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2019.2.tar.bz2"
  sha256 "46ecd0156c561d41e8aa87ce79340910cdf38373b759e737fcbba5df508e7b8e"
  head "git://anongit.freedesktop.org/git/xorg/proto/xorgproto"

  bottle do
    cellar :any_skip_relocation
    sha256 "9153a8547fae3bbe35ad0bd08bf8a51b4f0396264c569b4d9168b7979cebbb96" => :x86_64_linux
  end

  if build.head?
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => [:build, :test]

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    if build.head?
      ENV["NOCONFIGURE"] = "1"
      system "./autogen.sh"
    end

    system "./configure", *args
    system "make", "install"
  end

  test do
    assert_equal "-I#{include}", shell_output("pkg-config --cflags xproto").chomp
    assert_equal "-I#{include}/X11/dri", shell_output("pkg-config --cflags xf86driproto").chomp
  end
end
