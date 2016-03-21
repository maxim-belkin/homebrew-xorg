class XorgProtocols < Formula
  desc "Xorg Protocols"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url      "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/README.md"
  version  "latest"
  sha256   "846477dd316964fe52e9f73c3752d3c0383f7099046dd06ddfda92c2f9baad5d"
  # tag "linuxbrew"

  option "with-specs", "Build specifications"
  args = build.with?("specs") ? "with-specs" : ""

  # with specs
  res1 = %w[bigreqsproto fontsproto inputproto kbproto recordproto scrnsaverproto xcmiscproto xextproto xproto]

  # without specs
  res2 = %w[compositeproto damageproto dmxproto dri2proto dri3proto fixesproto glproto presentproto randrproto renderproto resourceproto videoproto xf86bigfontproto xf86dgaproto xf86driproto xf86vidmodeproto xineramaproto]

  res1.each do |r|
    depends_on r => args
  end

  res2.each do |r|
    depends_on r
  end

  def install
    ohai "Xorg Protocols have been installed!"
    prefix.install "README.md" => "xorg-protocols.md"
  end
end
