class XorgProtocols < Formula
  desc "X.Org Protocols"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/317ef5e60c62298a28f08bb44ca6a09d79793735/README.md"
  version "20170115"
  sha256 "76b4fd623d6b10d816069aedcffc411e2c9abc607533adf3fa810d7904b5f9d1"
  # tag "linuxbrew"

  bottle :unneeded

  option "with-specs", "Build specifications (where applicable)"

  # with specs
  reswithspec = %w[bigreqsproto fontsproto inputproto kbproto recordproto scrnsaverproto xcmiscproto xextproto xproto]

  # all resources. Sequence in which the packages are installed might be important
  resources = %w[bigreqsproto compositeproto damageproto dmxproto dri2proto dri3proto fixesproto fontsproto glproto inputproto kbproto presentproto randrproto recordproto renderproto resourceproto scrnsaverproto videoproto xcmiscproto xextproto xf86bigfontproto xf86dgaproto xf86driproto xf86vidmodeproto xineramaproto xproto]

  resources.each do |r|
    if reswithspec.include?(r) && build.with?("specs")
      depends_on "linuxbrew/xorg/#{r}" => "with-specs"
    else
      depends_on "linuxbrew/xorg/#{r}"
    end
  end

  def install
    ohai "X.Org Protocols have been installed!"
    prefix.install "README.md" => "xorg-protocols.md"
  end
end
