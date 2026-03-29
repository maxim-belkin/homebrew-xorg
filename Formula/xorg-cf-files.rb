class XorgCfFiles < Formula
  desc "X.Org Utilities: xorg-cf-files"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/util/xorg-cf-files-1.0.9.tar.xz"
  sha256 "07716eb1fe1fd1f8a1d6588457db0101cae70cb896d49dc65978c97b148ce976"
  license "MIT"

  depends_on "font-util" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  def install
    system "meson", "setup", "build",
           "-Dprefix=#{prefix}",
           "-Dwith-config-dir=#{lib}/X11/config"
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_predicate lib/"X11/config", :directory?
  end
end
