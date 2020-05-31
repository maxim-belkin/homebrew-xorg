class LibvaIntelDriver
  livecheck do
    url "https://github.com/intel/intel-vaapi-driver/releases"
    regex %r{Latest.*?href="/intel/intel-vaapi-driver/tree/v?([a-z0-9\.]+)}m
  end
end
