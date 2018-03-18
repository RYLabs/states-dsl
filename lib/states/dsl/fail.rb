module States
  module Dsl
    class Fail
      def type(type)
        @type = type
      end

      def error(err)
        @error = err
      end

      def cause(cause)
        @cause = cause
      end

      def serializable_hash
        h = {}
        h["Type"] = @type if @type
        h["Error"] = @error if @error
        h["Cause"] = @cause if @cause
        h
      end
    end
  end
end
