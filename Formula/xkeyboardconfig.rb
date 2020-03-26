class Xkeyboardconfig < Formula
  desc "Keyboard configuration database for the X Window System"
  homepage "https://www.freedesktop.org/wiki/Software/XKeyboardConfig/"
  url "https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-2.29.tar.bz2"
  sha256 "1d4175278bf06000683656763a8b1d3282c61a314b6db41260c8efe92d621802"

  bottle do
    cellar :any_skip_relocation
    sha256 "6abf9e8fc92ee379b7adf698492852d3d794189564f06976371ff63fd6c17a0a" => :x86_64_linux
  end

  head do
    url "https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git"
  end

  depends_on "gettext" => :build
  depends_on "intltool" => :build
  depends_on "libxslt" => :build
  depends_on "pkg-config" => [:build, :test]

  def install
    # Needed by intltool (xml::parser)
    ENV.prepend_path "PERL5LIB", "#{Formula["intltool"].libexec}/lib/perl5"

    # Fixed in the next release:
    # https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/c847c834
    inreplace "rules/compat/map-variants.py", /match\[[12]\]/, 'match.group(\1)'

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

  test do
    assert_predicate man7/"xkeyboard-config.7", :exist?
    assert_equal "#{share}/X11/xkb", shell_output("pkg-config --variable=xkb_base xkeyboard-config").chomp
    assert_match "Language: en_GB", shell_output("strings #{share}/locale/en_GB/LC_MESSAGES/xkeyboard-config.mo")
  end
end
