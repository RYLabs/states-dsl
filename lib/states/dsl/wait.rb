module States
  module Dsl
    class Wait
      def initialize(options={})
      end

      def seconds(seconds)
        @seconds = seconds
      end

      def seconds_path(path)
        @seconds_path = path
      end

      def timestamp(ts)
        @timestamp = ts
      end

      def timestamp_path(path)
        @timestamp_path = path
      end

      def serializable_hash
        h = {}
        if @seconds
          h["Seconds"] = @seconds
        elsif @seconds_path
          h["SecondsPath"] = @seconds_path
        elsif @timestamp
          h["Timestamp"] = @timestamp
        elsif @timestamp_path
          h["TimestampPath"] = @timestamp_path
        end
        h
      end
    end
  end
end
