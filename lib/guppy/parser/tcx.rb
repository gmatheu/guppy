module Guppy
  class Parser
    class TCX

      def initialize(xml_doc)
        @xml_doc = xml_doc
      end

      def activities
        @activities ||= [].tap do |activities|
          @xml_doc.css('Activity').each do |node|
            activities << build_activity(node)
          end
        end

        @activities
      end

      def laps(activity)
        [].tap do |laps|
          activity.css('Lap').each do |node|
            laps << build_lap(node)
          end
        end
      end

      def waypoints(lap)
        [].tap do |waypoints|
          lap.css('Trackpoint').each do |node|
            waypoints << build_waypoint(node)
          end
        end
      end

      private

        def build_activity(node)
          Activity.new({
            :parser => self,
            :node => node,
            :activity_type => Guppy::Utilities.normalize_activity_type(node.attr('Sport'))
          })
        end

        def build_lap(node)
          Lap.new({
            :parser => self,
            :node => node,
            :started_at => Time.parse(node.attr('StartTime')),
            :elapsed_time => node.at_css('TotalTimeSeconds').text.to_f,
            :distance => node.at_css('DistanceMeters').text.to_f,
            :avg_speed => avg_speed(node),
            :max_speed => node.at_css('MaximumSpeed').text.to_f,
            :calories_burned => node.at_css('Calories').text.to_i,
            :avg_heart_rate => node.at_css('AverageHeartRateBpm Value').text.to_i,
            :max_heart_rate => node.at_css('MaximumHeartRateBpm Value').text.to_i,
            :avg_cadence => avg_cadence(node),
            :max_cadence => max_cadence(node),
          })
        end

        def build_waypoint(node)
          Waypoint.new({
            :lat => node.at_css('LatitudeDegrees').text.to_f,
            :long => node.at_css('LongitudeDegrees').text.to_f,
            :altitude => node.at_css('AltitudeMeters').text.to_f
          })
        end

        def avg_speed(node)
          (
            node.css('DistanceMeters').text.to_f /
            node.css('TotalTimeSeconds').text.to_f
          ).to_f.round(4)
        end

        def avg_cadence(node)
          (cadence(node).inject(:+) / cadence(node).size).round
        end

        def max_cadence(node)
          cadence(node).max.round
        end

        def cadence(node)
          node.css('Cadence').map(&:text).map(&:to_f)
        end

    end
  end
end
