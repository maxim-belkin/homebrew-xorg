class Xf86miscproto < Formula
  desc "X.Org Protocol Headers: xf86miscproto"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/xf86miscproto-0.9.3.tar.bz2"
  sha256 "45b8ec6a4a8ca21066dce117e09dcc88539862e616e60fb391de05b36f63b095"
  # tag "linuxbrew"

  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end
end
