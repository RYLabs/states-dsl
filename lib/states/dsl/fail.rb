module States
  module Dsl
    class Fail
      def initialize(error=nil,cause=nil)
        @error, @cause = error, cause
      end

      def error(err)
        @error = err
      end

      def cause(cause)
        @cause = cause
      end

      def serializable_hash
        h = {}
        h["Error"] = @error if @error
        h["Cause"] = @cause if @cause
        h
      end
    end
  end
end
