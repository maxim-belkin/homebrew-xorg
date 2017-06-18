class Xorg < Formula
  desc "X.Org X11 libraries"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/317ef5e60c62298a28f08bb44ca6a09d79793735/README.md"
  version "20170115"
  sha256 "76b4fd623d6b10d816069aedcffc411e2c9abc607533adf3fa810d7904b5f9d1"
  # tag "linuxbrew"

  bottle :unneeded

  option "with-docs", "Build documentation and specifications (where applicable)"
  option "with-python3", "Build xcb-proto with python3 (default python is used otherwise)"
  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  # Build a list of requested compile flags for formulas
  args_docs = build.with?("docs") ? "with-docs" : ""
  args_devel_docs = build.with?("docs") ? "with-devel-docs" : ""
  args_specs = build.with?("docs") ? "with-specs" : ""
  args_check = build.without?("test") ? "without-test" : ""
  args_static = build.with?("static") ? "with-static" : ""

  # Frequently Used Option
  args_check_static = [args_check, args_static].reject(&:empty?)

  # If python3 has been requested,
  # add a direct dependence on xcb-proto package with python3 option
  if build.with?("python3")
    depends_on "linuxbrew/xorg/xcb-proto" => ["with-python3", args_check].reject(&:empty?)
  end

  depends_on "linuxbrew/xorg/xtrans" => [args_docs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libx11" => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxext" => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libfs" => args_check_static
  depends_on "linuxbrew/xorg/libice" => [args_check, args_static, args_docs, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libsm" => [args_check, args_static, args_docs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxscrnsaver" => args_check_static
  depends_on "linuxbrew/xorg/libxt" => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxmu" => [args_check, args_static, args_docs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxpm" => args_check_static
  depends_on "linuxbrew/xorg/libxaw" => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxfixes" => args_check_static
  depends_on "linuxbrew/xorg/libxcomposite" => args_check_static
  depends_on "linuxbrew/xorg/libxrender" => args_check_static
  depends_on "linuxbrew/xorg/libxcursor" => args_check_static
  depends_on "linuxbrew/xorg/libxdamage" => args_check_static
  depends_on "linuxbrew/xorg/libfontenc" => args_check_static
  depends_on "linuxbrew/xorg/libxfont" => [args_check, args_static, args_devel_docs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxft" => args_check_static
  depends_on "linuxbrew/xorg/libxi" => [args_check, args_static, args_docs, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxinerama" => args_check_static
  depends_on "linuxbrew/xorg/libxrandr" => args_check_static
  depends_on "linuxbrew/xorg/libxres" => args_check_static
  depends_on "linuxbrew/xorg/libxtst" => [args_check, args_static, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxv" => args_check_static
  depends_on "linuxbrew/xorg/libxvmc" => args_check_static
  depends_on "linuxbrew/xorg/libxxf86dga" => args_check_static
  depends_on "linuxbrew/xorg/libxxf86vm" => args_check_static
  depends_on "linuxbrew/xorg/libdmx" => args_check_static
  depends_on "linuxbrew/xorg/libpciaccess" => args_check_static
  depends_on "linuxbrew/xorg/libxkbfile" => args_check_static
  depends_on "linuxbrew/xorg/libxshmfence" => args_check_static

  if build.with?("docs") # or build.with?("specs")
    depends_on "linuxbrew/xorg/xorg-docs" => :recommended
    # xorg-docs is not a part of Xorg Libraries.
    # We build it by default when documentation / specifications are requested

    ### Provide a way to override default options for the packages.
    ### These options will be later combined into args_extra variable
    ### and passed to formulas that accept them
    # option "without-fop", "Build without fop support"
    # option "without-libxslt", "Build without libxslt support"
    # option "without-xorg-sgml-doctools", "Build without xorg-sgml-doctools support"
    # ###
  end

  def install
    ohai "X.Org has been installed!"
    prefix.install "README.md" => "xorg.md"
  end
end
