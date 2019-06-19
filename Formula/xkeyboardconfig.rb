class Xkeyboardconfig < Formula
  desc "Keyboard configuration database for the X Window System"
  homepage "https://xorg.freedesktop.org"
  url "https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-2.27.tar.bz2"
  sha256 "690daec8fea63526c07620c90e6f3f10aae34e94b6db6e30906173480721901f"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "91ec9583b3eadc646868a5bc4213986b51910e38cc6cb43afea2d89c9662d2e7" => :x86_64_linux
  end

  depends_on "gettext" => :build
  depends_on "intltool" => :build
  depends_on "libxslt" => :build
  depends_on "pkg-config" => :build

  def install
    # Needed by intltool (xml::parser)
    ENV.prepend_path "PERL5LIB", "#{Formula["intltool"].libexec}/lib/perl5"

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb-rules-symlink=xorg
      --disable-runtime-deps
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
