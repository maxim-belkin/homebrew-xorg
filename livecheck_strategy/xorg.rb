# frozen_string_literal: true

module LivecheckStrategy
  class Xorg
    NICE_NAME = "Xorg"
    NAME = NICE_NAME.downcase

    def self.match?(url)
      /(...\.x\.org|freedesktop\.org)/.match?(url)
    end

    def self.find_versions(url, regex)
      package_name = url.split("/")[-1].split("-")[0..-2].join("-")
      page_url = url.split("/")[0..-2].join("/")
      regex ||= /#{package_name}-([0-9.]+(?:\.[0-9.]+)*)\.tar\.[a-zA-Z0-9]*/
      PageMatch.find_versions(page_url, regex)
    end
  end
end
