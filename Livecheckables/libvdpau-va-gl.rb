class LibvdpauVaGl
  livecheck do
    url "https://github.com/i-rinat/libvdpau-va-gl/releases"
    regex %r{Latest.*?href="/i-rinat/libvdpau-va-gl/tree/v?([a-z0-9\.]+)}m
  end
end
