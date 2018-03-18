module States
  module Dsl

    class StateReference
      attr_accessor :resolved_to
      attr_reader :name

      def initialize(name, naming)
        @name = name
        @naming = naming
      end

      def to_s
        @resolved_to.to_s
      end
    end

  end
end
