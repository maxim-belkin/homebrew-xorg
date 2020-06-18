class LibvaInternal
  livecheck do
    url "https://github.com/intel/libva/releases"
    regex %r{Latest.*?href="/intel/libva/tree/v?([a-z0-9.]+)}m
  end
end
