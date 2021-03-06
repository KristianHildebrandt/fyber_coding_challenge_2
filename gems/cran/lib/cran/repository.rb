require 'rubygems/package'
require "httparty"
require 'tempfile'
require 'open-uri'
require 'zlib'
require "dcf"

OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0

module Cran
  class Repository
    class << self
      def fetch
        response = HTTParty.get('http://cran.r-project.org/src/contrib/PACKAGES').body

        parse(response)
      end

      def fetch_package_details(package)
        unpacked_package(package)
      end

      private

      def unpacked_package(package)
        file = package_file(package)

        Gem::Package::TarReader.new( Zlib::GzipReader.open file ) do |tar|
          tar.each do |entry|
             if entry.full_name.include?('/DESCRIPTION')
               c = entry.read
               return Dcf.parse(c).first
             end
          end
        end

        rescue

          byebug
      end

      def package_file(package)
        open(package_url(package))
      end

      def package_url(package)
        "http://cran.r-project.org/src/contrib/#{package['Package']}_#{package['Version']}.tar.gz"
      end

      def parse(response)
        Dcf.parse(response)
      end
    end
  end
end
