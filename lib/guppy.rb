require 'time'
require 'nokogiri'

Dir.glob('lib/**/*.rb').each do |lib|
  load lib unless lib =~ /guppy.rb$/
end

module Guppy
  TCX_NS = 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'
  PWX_NS = 'http://www.peaksware.com/PWX/1/0'
end

class UnsupportedFileType < StandardError
end
