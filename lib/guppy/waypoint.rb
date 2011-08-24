module Guppy
  class Waypoint

    attr_reader :lat, :long, :altitude

    def initialize(params={})
      params.each_pair do |attr, value|
        instance_variable_set(:"@#{attr}", value)
      end
    end

    def inspect
      %Q{
        #<#{self.class}
          lat: #{lat},
          long: #{long},
          altitude: #{altitude}>
      }.gsub(/^\s+/, '').gsub(/\n/, ' ').squeeze(' ')
    end
    alias :to_s :inspect

  end
end
