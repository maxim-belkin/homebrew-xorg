# xorg-protocols: Build a bottle for Linuxbrew
class XorgProtocols < Formula
  desc "X.Org Protocols"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url      "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/README.md"
  version  "latest"
  sha256   "846477dd316964fe52e9f73c3752d3c0383f7099046dd06ddfda92c2f9baad5d"
  # tag "linuxbrew"

  option "with-specs", "Build specifications (where applicable)"

  depends_on "xorg-sgml-doctools" => :build if build.with?("specs")

  # with specs
  reswithspec = %w[bigreqsproto fontsproto inputproto kbproto recordproto scrnsaverproto xcmiscproto xextproto xproto]

  # all resources. Sequence in which the packages are installed might be important
  resources = %w[bigreqsproto compositeproto damageproto dmxproto dri2proto dri3proto fixesproto fontsproto glproto inputproto kbproto presentproto randrproto recordproto renderproto resourceproto scrnsaverproto videoproto xcmiscproto xextproto xf86bigfontproto xf86dgaproto xf86driproto xf86vidmodeproto xineramaproto xproto]

  resources.each do |r|
    if reswithspec.include?(r) and build.with?("specs")
      depends_on r => "with-specs"
    else
      depends_on r
    end
  end

  def install
    ohai "Xorg Protocols have been installed!"
    prefix.install "README.md" => "xorg-protocols.md"
  end
end
