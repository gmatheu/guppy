module Guppy
  class Lap

    attr_reader :parser, :node, :started_at, :elapsed_time, :distance, 
      :avg_speed, :max_speed, :calories_burned, :avg_heart_rate, 
      :max_heart_rate, :avg_cadence, :max_cadence, :start_elevation,
      :max_elevation, :elevation_gained

    def initialize(params={})
      @parser = params.delete(:parser)
      @node = params.delete(:node)

      params.each_pair do |attr, value|
        instance_variable_set(:"@#{attr}", value)
      end
    end

    def waypoints
      @waypoints ||= parser.waypoints(node)
    end

    def to_hash
      {
        :started_at => started_at,
        :elapsed_time => elapsed_time,
        :distance => distance,
        :start_elevation => start_elevation,
        :max_elevation => max_elevation,
        # NOTE: work out elevation gained numbers
        :elevation_gained => elevation_gained,
        :avg_speed => avg_speed,
        :max_speed => max_speed,
        :calories_burned => calories_burned,
        :avg_heart_rate => avg_heart_rate,
        :max_heart_rate => max_heart_rate,
        :avg_cadence => avg_cadence,
        :max_cadence => max_cadence
      }
    end

    def inspect
      %Q{
        #<#{self.class}
          started_at: "#{started_at}",
          elapsed_time: #{elapsed_time},
          distance: #{distance},
          start_elevation: #{start_elevation},
          max_elevation: #{max_elevation},
          elevation_gained: #{elevation_gained},
          avg_speed: #{avg_speed},
          max_speed: #{max_speed},
          calories_burned: #{calories_burned},
          avg_heart_rate: #{avg_heart_rate},
          max_heart_rate: #{max_heart_rate},
          avg_cadence: #{avg_cadence},
          max_cadence: #{max_cadence}>
      }.gsub(/^\s+/, '').gsub(/\n/, ' ').squeeze(' ')
    end
    alias :to_s :inspect

  end
end
