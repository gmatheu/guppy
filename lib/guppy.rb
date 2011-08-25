require 'time'
require 'nokogiri'

base_dir = File.dirname(__FILE__)

Dir.glob("#{base_dir}/**/*.rb").each do |lib|
  require lib
end

module Guppy
  TCX_NS = 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'
  PWX_NS = 'http://www.peaksware.com/PWX/1/0'
end

class UnsupportedFileType < StandardError
end
