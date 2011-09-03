module Guppy
  module Utilities

    def self.normalize_activity_type(type)
      case type
        when 'Bike', 'Biking'
          'Cycling'
      end
    end

  end
end
