class IntelMediaDriver
  livecheck do
    url "https://github.com/intel/media-driver/releases"
    regex(%r{Latest.*?href="/intel/media-driver/archive/intel-media-?([a-z0-9.]+).tar.gz}m)
  end
end
