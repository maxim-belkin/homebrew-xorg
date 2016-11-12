class Xorg < Formula
  desc "X.Org X11 libraries"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/README.md"
  version  "20160314"
  sha256   "76b4fd623d6b10d816069aedcffc411e2c9abc607533adf3fa810d7904b5f9d1"
  # tag "linuxbrew"

  bottle :unneeded

  option "with-docs",       "Build documentation and specifications (where applicable)"
  option "with-python3",    "Build xcb-proto with python3 (default python is used otherwise)"
  option "without-test",    "Skip compile-time tests"
  option "with-static",     "Build static libraries (not recommended)"

  # Build a list of requested compile flags for formulas
  args_docs       = "#{ build.with?("docs")    ? "with-docs"        : "" }"
  args_devel_docs = "#{ build.with?("docs")    ? "with-devel-docs"  : "" }"
  args_specs      = "#{ build.with?("docs")    ? "with-specs"       : "" }"
  args_check      = "#{ build.without?("test") ? "without-test"     : "" }"
  args_static     = "#{ build.with?("static")  ? "with-static"      : "" }"

  # Frequently Used Option
  args_check_static = [args_check, args_static].reject(&:empty?)

  # If python3 has been requested,
  # add a direct dependence on xcb-proto package with python3 option
  if build.with?("python3")
    depends_on "xcb-proto" =>  ["with-python3", args_check].reject(&:empty?)
  end

  depends_on "xtrans"        => [args_docs].reject(&:empty?)
  depends_on "libx11"        => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "libxext"       => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "libfs"         => args_check_static
  depends_on "libice"        => [args_check, args_static, args_docs, args_specs].reject(&:empty?)
  depends_on "libsm"         => [args_check, args_static, args_docs].reject(&:empty?)
  depends_on "libxscrnsaver" => args_check_static
  depends_on "libxt"         => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "libxmu"        => [args_check, args_static, args_docs].reject(&:empty?)
  depends_on "libxpm"        => args_check_static
  depends_on "libxaw"        => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "libxfixes"     => args_check_static
  depends_on "libxcomposite" => args_check_static
  depends_on "libxrender"    => args_check_static
  depends_on "libxcursor"    => args_check_static
  depends_on "libxdamage"    => args_check_static
  depends_on "libfontenc"    => args_check_static
  depends_on "libxfont"      => [args_check, args_static, args_devel_docs].reject(&:empty?)
  depends_on "libxft"        => args_check_static
  depends_on "libxi"         => [args_check, args_static, args_docs, args_specs].reject(&:empty?)
  depends_on "libxinerama"   => args_check_static
  depends_on "libxrandr"     => args_check_static
  depends_on "libxres"       => args_check_static
  depends_on "libxtst"       => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "libxv"         => args_check_static
  depends_on "libxvmc"       => args_check_static
  depends_on "libxxf86dga"   => args_check_static
  depends_on "libxxf86vm"    => args_check_static
  depends_on "libdmx"        => args_check_static
  depends_on "libpciaccess"  => args_check_static
  depends_on "libxkbfile"    => args_check_static
  depends_on "libxshmfence"  => args_check_static

  if build.with?("docs") # or build.with?("specs")
    depends_on "xorg-docs" => :recommended
    # xorg-docs is not a part of Xorg Libraries.
    # We build it by default when documentation / specifications are requested

    ### Provide a way to override default options for the packages.
    ### These options will be later combined into args_extra variable
    ### and passed to formulas that accept them
    # option "without-fop",     "Build without fop support"
    # option "without-libxslt", "Build without libxslt support"
    # option "without-xorg-sgml-doctools", "Build without xorg-sgml-doctools support"
    # ###
  end

  def install
    ohai "Xorg has been installed!"
    prefix.install "README.md" => "xorg.md"
  end
end
