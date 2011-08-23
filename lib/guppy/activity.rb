module Guppy
  class Activity

    attr_reader :parser, :node, :activity_type, :started_at, :elapsed_time,
      :distance, :avg_speed, :max_speed, :calories_burned, :avg_heart_rate,
      :max_heart_rate, :avg_cadence, :max_cadence

    def initialize(params={})
      @parser = params.delete(:parser)
      @node = params.delete(:node)

      params.each_pair do |attr, value|
        instance_variable_set(:"@#{attr}", value)
      end

      populate_stats
    end

    def laps
      @laps ||= parser.laps(@node)
    end

    def inspect
      %Q{
        #<#{self.class}
          activity_type: "#{activity_type}",
          started_at: "#{started_at}",
          elapsed_time: #{elapsed_time},
          distance: #{distance},
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

    private

      def populate_stats
        @started_at = nil
        @elapsed_time = 0
        @distance = 0
        @avg_speed = 0
        @max_speed = 0
        @calories_burned = 0
        @avg_heart_rate = 0
        @max_heart_rate = 0
        @avg_cadence = 0
        @max_cadence = 0

        @started_at = laps.first.started_at
        @avg_speed += average_across_laps(:avg_speed).round(4)
        @max_speed += average_across_laps(:max_speed).round(4)
        @avg_heart_rate += average_across_laps(:avg_heart_rate).round
        @max_heart_rate += average_across_laps(:max_heart_rate).round
        @avg_cadence += average_across_laps(:avg_cadence).round
        @max_cadence += average_across_laps(:max_cadence).round

        laps.each do |lap|
          @elapsed_time += lap.elapsed_time
          @distance += lap.distance
          @calories_burned += lap.calories_burned
        end
      end

      def average_across_laps(value)
        (laps.map(&value).inject(:+) / laps.size)
      end

  end
end
