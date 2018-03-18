module States
  module Dsl
    class Retry
      include States::Dsl::ErrorSupport

      def initialize(options={})
        @error_equals = ensure_errors_array(options[:error_equals])
        @max_attempts = options[:max_attempts]
        @backoff_rate = options[:backoff_rate]
        @interval_seconds = options[:interval_seconds]
      end

      def max_attempts(n)
        @max_attempts = n
      end

      def backoff_rate(r)
        @backoff_rate = r
      end

      def interval_seconds(s)
        @interval_seconds = s
      end

      def serializable_hash
        h = { "ErrorEquals" => @error_equals }
        h["MaxAttempts"] = @max_attempts if @max_attempts
        h["BackoffRate"] = @backoff_rate if @backoff_rate
        h["IntervalSeconds"] = @interval_seconds if @interval_seconds
        h
      end
    end
  end
end
